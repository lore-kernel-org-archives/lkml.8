Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D899C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1765F2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYPyZxkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbgDBWq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:46:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34989 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBWq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:46:56 -0400
Received: by mail-io1-f68.google.com with SMTP id o3so5532157ioh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQnxweQnqXfPXtvAjWkG4LAwMm7QgxQOU06/1lbhuSY=;
        b=qYPyZxkk8z01LGWskSrm9aG/7nt3J+cgEH/SymGNN597NCfm6MCdZIy6TzISZy66q4
         pj6rRU04jWHnuCETpqmyHTLKqZiwVuEyeFh5Rr0b3hSMwg5eGng2Ha2xdSdKsvmQxAOB
         QPSasGKfa8n/l/zHMpnSI/pAoBE+Rpko2nlur98dOVL1Ua5pOL9Ld4KHgbshpQDQcTna
         ZN9LC+pER0Nd3/NjtUkjv0UtAskAfOkP49pxmJi+E9xuTviSHaZd0wPMgN1pFs3Uk30N
         wghTmqvUOM9XnmeCBS/2N/NZZe5q7C6DI1LgBPQnuYA89x4cjlENgCSO+fUrkfhakK+1
         XFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQnxweQnqXfPXtvAjWkG4LAwMm7QgxQOU06/1lbhuSY=;
        b=uIDwbEdLwtKQX2Qin9347d/5MkIlPeLiCPgNcR1jghNZTWLPI4c/Ru2oz39fXhrEzS
         5ICsEGhp/BHf7BUmIxtSu87xUESWuxNv3qSNmnb0eC2c2Bx6yYIgIbRur3j+bnpVko2t
         LBTVJtMxq0uhFVRdR97bccq5Ft3D7eYo93hxHD3I5H8rXxO7//Mp69JmvJ7gsMgM58Bz
         4cyz8P8GKvPjWgoQKiJJbZzFbGA4AATKCYPlYcBzm5LP0vfRAq320plu6ojUimLP8aou
         R3BniDuLJGeZTXtrA2JQt4YYVpyTXSgkpv1mO++NSXQpCFo95Vr6csVNeMynmUDUYAdE
         dWOQ==
X-Gm-Message-State: AGi0Pub3JE7StPeanodflAOMAY463q3kP2R74A19NGryL+AOPN3GElZD
        CqrAtZI1SNxgvaEkCX9q5VozVnNM0dg2+7iGxpleqlNTnzo=
X-Google-Smtp-Source: APiQypJ96SzZqukS6zpyCpAiLjdlBVXL/4HDhO4ilUK7VCKGO7VXzhUxFl62HyckGydrE57jcQ6v+hhAdMKSuRB5sZg=
X-Received: by 2002:a05:6638:d6:: with SMTP id w22mr494171jao.72.1585867615842;
 Thu, 02 Apr 2020 15:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
In-Reply-To: <20200402195156.626430-1-leonardo@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 3 Apr 2020 09:46:44 +1100
Message-ID: <CAOSf1CEihBDDRny5S_7TA5Cqbdgsh6zN=kdq83OSgaLbRphtrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 6:55 AM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> While providing guests, it's desirable to resize it's memory on demand.
>
> By now, it's possible to do so by creating a guest with a small base
> memory, hot-plugging all the rest, and using 'movable_node' kernel
> command-line parameter, which puts all hot-plugged memory in
> ZONE_MOVABLE, allowing it to be removed whenever needed.
>
> But there is an issue regarding guest reboot:
> If memory is hot-plugged, and then the guest is rebooted, all hot-plugged
> memory goes to ZONE_NORMAL, which offers no guaranteed hot-removal.
> It usually prevents this memory to be hot-removed from the guest.
>
> It's possible to use device-tree information to fix that behavior, as
> it stores flags for LMB ranges on ibm,dynamic-memory-vN.
> It involves marking each memblock with the correct flags as hotpluggable
> memory, which mm/memblock.c puts in ZONE_MOVABLE during boot if
> 'movable_node' is passed.

I don't really understand why the flag is needed at all. According to
PAPR any memory provided by dynamic reconfiguration can be hot-removed
so why aren't we treating all DR memory as hot removable? The only
memory guaranteed to be there 100% of the time is what's in the
/memory@0 node since that's supposed to cover the real mode area.

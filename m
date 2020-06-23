Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DBF206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuMyxAtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgFWC0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgFWC0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:26:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:26:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u13so21881497iol.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=JeBmgi5MEU9b+rC0zQ3g7Frqafi6s+x5xwkR37z5J/o=;
        b=kuMyxAtE429gbGKXs0yUURMUEj8Hut2RFZVRENPJF3jlOe6Ds+dkGCciDFkXcN1PVl
         pDNAda3WUwYjYV18kbZmesCbBwZbFsRAfWELdIJnNsqHXuFMuuPuSdWfAdv9OKT7uM8P
         UhP46VwtRtf+l4iSvS8JA6dM7ISulkwizRImkHuvmB+MX9Hljvm5GfB1HBotPbU0TVm6
         cM8JdfD7WIMcvJdFVOkW8GGFAP4XQTEX7iOTtop6NhkDQ+RY0OcPm4VTLV3uDXhpmEb9
         ftVgDW7m8yjRQhxrQH1L9GJQ+GjumtTTyrBcP+Rb8i7PH7gb9BorHO9Hkx1QykEUOVT7
         oaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=JeBmgi5MEU9b+rC0zQ3g7Frqafi6s+x5xwkR37z5J/o=;
        b=CjSfwSe0o7UJ6fSmP63pVmwOM2QZAqiGplcJWiD5Vl9Dl3Lf59SENQFwfODy2IZPQO
         MpKAqLf1rCVVOJVpWIAPfXf/9aaO3WdzFW4KfbUc+10gG4QJfWjW3WEWqlemWYx+8Obc
         LMPmJ/DxRpKoO2PYLKX2TzKVWC7FDyPQUYl+yPXsbaPQYizdHxljSPRF/L7CKFzJGHji
         redrQIuwsXOOR1j7SQzXTPidAEAEgp7KjYjZCplT/UvMNAM0PJXTPjbvp7PdY9Bl26cX
         ZuGQMTC4vhHv+5dZIQkwus393e7sZf36GqxPQowBkeokOPIn3Xi2bItkyrBuTa/a9KQP
         D5eA==
X-Gm-Message-State: AOAM530+CxWb0GhaxQKkpC6OrDAdkiRPlJ4USkbQ/mVo23/akqPGQDeN
        XNtMq24m3Aqy12y/uC7HX5A=
X-Google-Smtp-Source: ABdhPJyQH5TToRDJNIWo9OFfkuK/CeUceNCneJXJeV7ZfMXiwI0JilEJ+A7umu/uvQnAfannLgWGBQ==
X-Received: by 2002:a5d:8905:: with SMTP id b5mr1165806ion.95.1592879192981;
        Mon, 22 Jun 2020 19:26:32 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id w16sm8787996iom.27.2020.06.22.19.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:26:32 -0700 (PDT)
Message-ID: <de68e4ed43f802624b5403b548557084ee63e325.camel@gmail.com>
Subject: Re: [PATCH 3/4] powerpc/pseries/iommu: Move window-removing part of
 remove_ddw into remove_dma_window
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 22 Jun 2020 23:26:18 -0300
In-Reply-To: <CAOSf1CEC-tYH1so5b4P7dQ7s8v1o4qy_u5CG7LKtKNnRQvC4-w@mail.gmail.com>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-4-leobras.c@gmail.com>
         <51201582-efe5-85df-7e65-a998e91ab63f@ozlabs.ru>
         <ccf7b591f2bf61ba4705699b2e2b050c3cf48d99.camel@gmail.com>
         <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
         <CAOSf1CEC-tYH1so5b4P7dQ7s8v1o4qy_u5CG7LKtKNnRQvC4-w@mail.gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:33 +1000, Oliver O'Halloran wrote:
> On Tue, Jun 23, 2020 at 11:12 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > On 23/06/2020 04:59, Leonardo Bras wrote:
> > > > Also, despite this particular file, the "pdn" name is usually used for
> > > > struct pci_dn (not device_node), let's keep it that way.
> > > 
> > > Sure, I got confused for some time about this, as we have:
> > > static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn).
> > > but on *_ddw() we have "struct pci_dn *pdn".
> > 
> > True again, not the cleanest style here.
> > 
> > 
> > > I will also add a patch that renames those 'struct device_node *pdn' to
> > > something like 'struct device_node *parent_dn'.
> 
> I usually go with "np" or "node". In this case I'd use "parent_np" or
> just "parent." As you said pci_dn conventionally uses pdn so that
> should be avoided if at all possible. There's some places that just
> use "dn" for device_node, but I don't think that's something we should
> encourage due to how similar it is to pdn.

Sure, I will try that.

> 
> > I would not go that far, we (well, Oliver) are getting rid of many
> > occurrences of pci_dn and Oliver may have a stronger opinion here.
> 
> I'm trying to remove the use of pci_dn from non-RTAS platforms which
> doesn't apply to pseries. For RTAS platforms having pci_dn sort of
> makes sense since it's used to cache data from the device_node and
> having it saves you from needing to parse and validate the DT at
> runtime since we're supposed to be relying on the FW provided settings
> in the DT. I want to get rid of it on PowerNV because it's become a
> dumping ground for random bits and pieces of platform specific data.
> It's confusing at best and IMO it duplicates a lot of what's already
> available in the per-PHB structures which the platform specific stuff
> should actually be looking at.
> 
> Oliver

Best regards,
Leonardo Bras


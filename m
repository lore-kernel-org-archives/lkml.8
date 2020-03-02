Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E5C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F57B2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgawhBRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCBWSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:18:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33169 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:18:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id a25so927969wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7SzOkQ6sd0S38QbCyvRBb51L6pZuZ/wIs7mZk/AE8Pw=;
        b=kgawhBRi1VrmDrFQgMsBn4QCL75ooMSD9VNmosY5S3toaV/UEeN1KOGOzB9S+PihJ2
         VgcendwtfFF8Yuro0+zjcX244T16q40fqWiIgydyr3QsTRB4Ah7hMJfeNJdeikmYMhaf
         8OsvnXkbeahCDsIwE0bc/Pf9vIggdDY+JQ9yu4QR6mavsRFL5PFtCafZFAwx+dB3OyWc
         FE82+w+okkwiBhn5h1tDzh/7lZ4Qxnnvq9RKZ5egWB+mGT4tj4dKLJM/7hIawNB0v3PI
         VTGgdzqMNReByXDKrZrjhjRIs3NcZJOcDYhejKvLlZCAM9YtiwYJo+mhJxk5HtME0bsJ
         RwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7SzOkQ6sd0S38QbCyvRBb51L6pZuZ/wIs7mZk/AE8Pw=;
        b=o3PsQiXf/1O/0NwaXYJ7v4/ou2JHdI4+9LFgqxLLTiEkdtALSJm2LkITpbeSclOjDG
         9259qzz7bZ5EvM3g3Mor7D4HZAGHK17aOWMZTqTQKs0BZpZbN0JYjSNl3/2nukbq5y8S
         H9qL2TACntoliBxcyJZ0l1E0m35Dcle/5iQrvpN86ZtkoDNrijy+yY35NP5Yzw/uKSPH
         afF/VmdvrrehoMzeVFSefH0TQkJp/ImuSF42UacoJzQ8zXsBMBXAasPgRq9Ub6Vw2IyI
         IQSaWMN/+kmVkfBwJ8oB+G+TBlfIuln/163fYXcs4FiOAlQ3U7QPWqcTQWSax3lRiwa2
         CSrg==
X-Gm-Message-State: ANhLgQ2WY9pOEBvegmS8wAX2iDvb6bv3CZsI+l/qlFQsBfrhk6DaBl68
        lGCECfBA29l0PXD//t7bN1s=
X-Google-Smtp-Source: ADFU+vtm3v5RKkFxeFN4fWtkHqhHV3daajsgvmUfin1v5VU2qsMSSgu8vFJ21B9gNTcGe2n5hYtiiw==
X-Received: by 2002:a1c:41c3:: with SMTP id o186mr480436wma.27.1583187509682;
        Mon, 02 Mar 2020 14:18:29 -0800 (PST)
Received: from kbp1-lhp-F74019 (a81-14-236-68.net-htp.de. [81.14.236.68])
        by smtp.gmail.com with ESMTPSA id g187sm586933wma.5.2020.03.02.14.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 14:18:29 -0800 (PST)
Date:   Tue, 3 Mar 2020 00:18:26 +0200
From:   Yan Yankovskyi <yyankovskyi@gmail.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: Use 'unsigned int' instead of 'unsigned'
Message-ID: <20200302221826.GA18206@kbp1-lhp-F74019>
References: <20200229223035.GA28145@kbp1-lhp-F74019>
 <fba833c4-3173-0094-b4ec-53e9f42bfb3e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba833c4-3173-0094-b4ec-53e9f42bfb3e@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 10:11 Jan Beulich wrote:
> ... evtchn_port_t here and elsewhere.

There are some interfaces with signed int as a type for port, e.g. in
include/xen/events.h.
Should I create additional patch to resolve inconsistency with evtchn
interface?
Or you suggest combining these changes into the existing patch?

Also as I understand 'evtchn' and 'port' are essentially the same
entities from perspective of local domain, related to each other roughly
like connection and file descriptor pair. What do you think about
renaming all 'evtchn' arguments and variables to 'port'?
It will eliminate inconsistencies in the code, for example
in include/xen/interface/event_channel.h and include/xen/events.h.

Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F579C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597612073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="LMkWN3sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGTU5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:56:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81712C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:56:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so470651pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJ/tpvydDMz3twTYDJaAWaLUOCGbbQA7F9t0js/9ubo=;
        b=LMkWN3sMUU3w+Zpa3p4GKsHoJNFENcMaDdvt9aU9XWldoN3wW8WnX1d18uP7IkxXf0
         8qlyHT8vbm3QGQdwM8TfrYm2M22oH40YkwbbFU0b6Pt/RoLRaPoWrVvVFlo86V5o8lnM
         B9geSxKFKZ12Yf3/7CadewCiEdVLiGJ7pSvGCY+1QuXpD+Gpt0l+37s0tDGsUE1BTIdJ
         QejJBGbHYfWXM4f+ewmbGRtT6Z6sYwz5OfTGSfrZvPSc2oL11iiWhynXBbOgdd4Bnnm+
         AxVMqY54R1kaS6HelhqnNwbfRUZ9d88V/X5h7/LLYjtfcMORcZi/+6kqziOpLF6vLrAB
         mY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJ/tpvydDMz3twTYDJaAWaLUOCGbbQA7F9t0js/9ubo=;
        b=tMH8R7FVK601trneYxk7k/Oar+OKDJ6WrUN7O9B7ahueQ1ddTEqvd8N0sKqR9nWkou
         I5p/hc5Na+GHZcoJxDuGQksCleL2YLcmlPYRuvRjn7aC1wYoXzXrqkZs+99AHRu3SOad
         4Rs2fcn2F8O4jqAGIQ/ic5WnAqxlUvZIbpgXm8+XqBGEayv4L7Qwy20nEg69PyS9Glf8
         xi3Wd7/YQzty3oZ7Iu6Qi1kEl+YSbHPGqtqTmiMyM5uYtFWlg4SK5MUp+Lv6lo7909eV
         UO/LX8vcS6c0gqiMMaT4b90HHmE86YkreNTOKuEezaQsbdNmb7lN4L4VamYa19X2/uuv
         m0ZA==
X-Gm-Message-State: AOAM532pVcto5kK1z6Wbf0ZK+ZRspFCEOEGWSw/GxxoKYSCnkvuYVZRV
        6ZVbkUotBwdnjEP2nMmh+/zH2A==
X-Google-Smtp-Source: ABdhPJwT+gAR9vIZr/AMDE2WT/mxAc7CINRzqUbjbWq7crAyMx4DmBGZkdkZ/TvJvmiFIEYFa/OJqg==
X-Received: by 2002:a17:90a:8d12:: with SMTP id c18mr1155557pjo.222.1595278618823;
        Mon, 20 Jul 2020 13:56:58 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a30sm18161011pfr.87.2020.07.20.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:56:58 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:56:50 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "Sriram Krishnan (srirakr2)" <srirakr2@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Malcolm Bumgardner (mbumgard)" <mbumgard@cisco.com>
Subject: Re: [PATCH v2] AF_PACKET doesnt strip VLAN information
Message-ID: <20200720135650.1939665b@hermes.lan>
In-Reply-To: <CAF=yD-+gCkPVkXwcH6KiKYGV77TvpZiDo=3YyXeuGFk=TR2dcw@mail.gmail.com>
References: <20200718091732.8761-1-srirakr2@cisco.com>
        <CA+FuTSdfvctFD3AVMHzQV9efQERcKVE1TcYVD_T84eSgq9x4OA@mail.gmail.com>
        <CY4PR1101MB21013DCD55B754E29AF4A838907B0@CY4PR1101MB2101.namprd11.prod.outlook.com>
        <CAF=yD-+gCkPVkXwcH6KiKYGV77TvpZiDo=3YyXeuGFk=TR2dcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 09:52:27 -0400
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> On Mon, Jul 20, 2020 at 12:27 AM Sriram Krishnan (srirakr2)
> <srirakr2@cisco.com> wrote:
> >
> > +Stephen Hemminger
> >
> > Hi Willem,
> > Thanks for looking into the code, I understand that this is more of a generic problem wherein many of the filtering functions assume the vlan tag to be in the skb rather than in the packet. Hence we moved the fix from the driver to the common AF packet that our solution uses.
> >
> > I recall from the v1 of the patch you had mentioned other common areas where this fix might be relevant (such as tap/tun), but I'm afraid I cant comprehensively test those patches out. Please let me know your thoughts  
> 
> Please use plain text to respond. HTML replies do not reach the list.
> 
> Can you be more precise in which other code besides the hyper-v driver
> is affected? Do you have an example?
> 
> This is a resubmit of the original patch. My previous
> questions/concerns remain valid:
> 
> - if the function can now fail, all callers must be updated to detect
> and handle that
> 
> - any solution should probably address all inputs into the tx path:
> packet sockets, tuntap, virtio-net
> 
> - this only addresses packet sockets with ETH_P_ALL/ETH_P_NONE. Not
> sockets that set ETH_P_8021Q
> 
> - which code in the transmit stack requires the tag to be in the skb,
> and does this problem after this patch still persist for Q-in-Q?

It matters because the problem is generic, not just to the netvsc driver.
For example, BPF programs and netfilter rules will see different packets
when send is through AF_PACKET than they would see for sends from the
kernel stack.

Presenting uniform data to the lower layers makes sense.

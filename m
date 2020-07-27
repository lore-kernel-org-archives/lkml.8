Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C38BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6020738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS8CO0k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgG0Tl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgG0Tl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:41:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E3C061794;
        Mon, 27 Jul 2020 12:41:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so2796679pfh.3;
        Mon, 27 Jul 2020 12:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HsP2ETe5pQS8UqrtlgdyGqg7uS6MUHLsMN/+VIpwKyM=;
        b=cS8CO0k1BkjvF8UX1gXbAH/kZSHdWXyDYCLteyY3XabHYSl9/pWPbnY5dD4nRxStrz
         gCPOv+QolEyfL6jw/bNqYw9BOG3G2ZbGT0FQKLM9HAnyqGiT8XQkNaNdWwspBOVh+34f
         SKtsvKGzXVPwsnQ8FhWX1VmGgdPJdfSVhT/FSL2XEuKG9+FCPFZjGUWTR8V2a27g47Ps
         whNMq9FpAlfeHjPcbJGN+7aRZYkgyZvgmAI7HFgGXPv48lRaSp3lrvhQv0ok2lmJfY5V
         I2CKM0UdU7SsSTCfvSRdz3/sq5hY6bm+JMlOjYclmdra35BaV9dhT9qU51o0eASO+jTo
         swxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HsP2ETe5pQS8UqrtlgdyGqg7uS6MUHLsMN/+VIpwKyM=;
        b=VadqCHyp5uGNtqfLjxyE5qZh1pllXR7JPKK5s+HIKFxHP0qBby/NysWCCGpX4vl4Ug
         fA+vepiFqCpOQ1dZRP959/vvTOptQPJ+4H/BXlkbvpU02nL7eFbFDSuTCCvvivfeKOMc
         8P5advnzXHZi3eT1rBYCb44qqP2uiHzNI/qiq6kNiYy/4njk8zXaHhhhuyWYcxDWsSTl
         zuBZpvf6BRTXw3aiDvW7zALeqkTi3zMlIHXxtQ0Ns818hV5ebpxaa7sluONZZfNwmmQb
         sBOkgx6rpH0aJAU/sR3gWLZl9kAoCSC47h/JfX+ogp0jtasYZmO2uyf2r38mTc8L9aGQ
         r7oA==
X-Gm-Message-State: AOAM533M/RlJBa1Ss/7CKo/8QmqqICmDDeKxfvaFb7MGIT1KinPaSuL0
        4SQ9medpe7bX+CUCYj/SHdZLGJ/kNzooYuH5jmI=
X-Google-Smtp-Source: ABdhPJzWuIVSUuVwZ6a6ME03FyveJQGaX7eCAfeLtRyhfLDX/sJu4H/PsCIx5iSAmmwzDNGOSPucdpsFHQaI0ufIc7U=
X-Received: by 2002:a65:6707:: with SMTP id u7mr20981952pgf.233.1595878887813;
 Mon, 27 Jul 2020 12:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
In-Reply-To: <20200726110524.151957-1-xie.he.0141@gmail.com>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Mon, 27 Jul 2020 12:41:16 -0700
Message-ID: <CAJht_EOAGFkVXsrJefWNMDn_D5HhH+ODkqE03BULyzb_Ma8A5A@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux X25 <linux-x25@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cong Wang,

I'm wishing to change a driver from using "hard_header_len" to using
"needed_headroom" to declare its needed headroom. I submitted a patch
and it is decided it needs to be reviewed. I see you participated in
"hard_header_len vs needed_headroom" discussions in the past. Can you
help me review this patch? Thanks!

The patch is at:
http://patchwork.ozlabs.org/project/netdev/patch/20200726110524.151957-1-xie.he.0141@gmail.com/

In my understanding, hard_header_len should be the length of the header
created by dev_hard_header. Any additional headroom needed should be
declared in needed_headroom instead of hard_header_len. I came to this
conclusion by examining the logic of net/packet/af_packet.c:packet_snd.

What do you think?

Thanks!

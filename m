Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04050C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C4A2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLqeK807"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgDXJPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:15:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC7AC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 02:15:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so2541307pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
        b=hLqeK807AIl6oploSr0Ba6ECKM0p7TJKe7Ek3q2RmBD0GalqEqtMmRgxnkTlqcmdzV
         ImxmiB17WCsKRZzUUwf15tdxBIvx8kVfKqvsamdbhlDfruuX1a/rIrojrXzb7AmzvZnw
         L/qkKYRqVsQM5Y6gA907HSjwfpLGR5zddHhtKDXluMyl6xz5DNoWeedHM8EwIj+zJRct
         YGRYb5B6VaHlc00x4WiOwUXXe0lfY6iZ6Zs2FtKP23Al/RAc2TlBD5WToZDRaVsNd0VF
         8JosDlT9ZgqC9CyuqWcb0/7Dh8Wv8VY7VpWPMCNx0aa4cmIudmY0/WbW+98c0jYN39hH
         APeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GiWyPt7yzmACBp+FM5CBU27WrasEL3zEd6YMjPXRRYw=;
        b=EavR9/VQ8RY/TRvgIrHnRl2PurDJS3Po5bWS0HTuRcmEI1oN2row1q3jChBPJfNhTB
         2HKW2KluAOqmjPAPw5ybS75SbYLS3xD0l0HcwVoqxTH72NdUXUZNIr6dDLL6oSNycYyk
         PJFn1MPXS3VBy6ztyZINSY0az6zTj19vHnA8l1nDaFxmFSfo8OgrDbaCl7sT5OrfCzSb
         YbfO0fypDAKTl877FEwK93a6wmZTErUHh4SlAjHYu/4zNLg7oLtVKiiH5D3QVWVGA3aB
         W8RRlcRbzi2YVGTBAdWtf3UP9392SiPOAMG92vE3MFLOf6kXrYkttPXB7V1xdpGdHJQN
         TnVQ==
X-Gm-Message-State: AGi0PuZuNW+8AR145xHdvM2sIvunGxyrAsP6dvKF1Ao9U1HkzsW5UXaT
        MSxgo60+HfXvRy2G7Bv5QUk=
X-Google-Smtp-Source: APiQypJMf2vN0y0/aXmoENydAS7xfN3ytEgap8oA8faei9WM71d4PxRiV+783Qla1nkRQ/PT8Su4cw==
X-Received: by 2002:a17:902:8218:: with SMTP id x24mr8335621pln.192.1587719748506;
        Fri, 24 Apr 2020 02:15:48 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id u13sm4301584pjb.45.2020.04.24.02.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 02:15:48 -0700 (PDT)
Date:   Fri, 24 Apr 2020 02:15:33 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_esai: Remove the tasklet
Message-ID: <20200424091533.GA8856@Asurada>
References: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587711246-27226-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 02:54:06PM +0800, Shengjiu Wang wrote:
> Remove tasklet for it may cause the reset operation
> can't be handled immediately, then there will be
> endless xrun interrupt.

The reset routine is really long and expensive, so not sure
if it'd be good to do it completely inside HW ISR. Have you
tried to clear xEIE bits to disable xrun interrupts, before
scheduling the tasklet? If that does not solve the problem,
we may go for this change.

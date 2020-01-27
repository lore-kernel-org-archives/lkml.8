Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA01C35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8C5214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeVNAZ2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgA0JEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:04:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40863 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgA0JEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:04:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so10162434wrn.7;
        Mon, 27 Jan 2020 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ovlmj7KqPymDm9aXcdFrkrxdRgp/dsef1ye5t7e6xjI=;
        b=oeVNAZ2lyhfXA5BPCFu6Gf5DUXNnbPWj/48D56BQN9aoSXYPJJOfOnPnHtFXgk8drK
         5qfAxGZBBvxOa/wTN3tviWRj2lOBG0mLFs0k8a9spWRnSOQoeIzC+uO+0kI1D78lyB1U
         tUiox7olbO5IMKbh1RL8gdGbwnUFTvxA3zVfDZaPTIGqnnHcFuK2rnR3Dr+33umFOCCZ
         hBDdADZVspJHhNxs9hlzWqKPE5lzXCw/CfIxkDP+HelLxrduZupN5CQQQQPYlylmbtmZ
         EihtH+UUHPA/5ItYwt00M42mi8/Dv7pntdt3suJXyyeLB9BNTmYCkB4lH8L+2kEcNTSy
         oHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ovlmj7KqPymDm9aXcdFrkrxdRgp/dsef1ye5t7e6xjI=;
        b=gIUJn15bCsOrYF2a19ndml98FIvgDOtukpSRdMFjJdsVH1X9YB8QZCuLeOrPzdUAHZ
         3s3fH+Sib00f0k7ldSP2d43NYMpRUP01YqwgGQ95ChiV1e0SqDvBy6a01ibfujLvmdOW
         MVTNkOY/0J1RUgSB0HBVLYRzx6r7Gat22DBRH7Cb6QoLB1lm29npGzuWUhrqrfaVrvm/
         CpH15r146T+s79Oed/A9Xbx69pYqyb7P9BsOnLaHpJDn92K9YkVXHXpMlA9i7LHaMbtK
         AKA78nCnCJlcNbLubp2ZiXAdLGmzj4egOVK1HO6UkHJpxF3WQ/4tvoEIMRHJY0GBgQYb
         kxzA==
X-Gm-Message-State: APjAAAVNd2k9NbdaIXW7HdpLbwtwfH5XZ0KZYeyx620VlNA684LjGRGH
        RryIY6l9CnaYJoyGnhiAuLc=
X-Google-Smtp-Source: APXvYqzeXQOdeW7r3uM1ZF0LJhGtln+VSnRxH2Y1gg0P41wUA0HZa4x7Kk9VoZB7/VELHzJ0CgTdCA==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr19340178wrr.183.1580115851668;
        Mon, 27 Jan 2020 01:04:11 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e17sm2215457wma.12.2020.01.27.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 01:04:10 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:04:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Christoph Hellwig <hch@lst.de>, Namjae Jeon <linkinjeon@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu, sj1557.seo@samsung.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v13 00/13] add the latest exfat driver
Message-ID: <20200127090409.vvv7sd2uohmliwk5@pali>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
 <20200125213228.GA5518@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200125213228.GA5518@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 January 2020 22:32:28 Christoph Hellwig wrote:
> The RCU changes looks sensible to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Great! Are there any other issues with this last version?

If not, Greg would you take this patch series?

-- 
Pali Rohár
pali.rohar@gmail.com

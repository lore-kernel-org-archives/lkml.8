Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF71C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68BA20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ldgxYSTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCWP53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:57:29 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52255 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCWP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:57:29 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so12100pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xdFeUkMil+HXZ4ax6FoPNFtoFq6FUJmJ0Q6Zva1VrE=;
        b=ldgxYSTapIFo5c9XASqPk/M1zo3L8kU4x3tLHAuxMZ3Ni6aYrfoaqEhE+GIihzMifA
         hKtcxmeGZgwq3VV21jgiUJ/leOO59zn8qHUpukZvTMgPXL0f50oYzRetsOj5RfOr5wo6
         hNb2+NEVCcjd2OVVKPiwQIVBfHMX/axtpRPHrL0Iv2sk/crj1nPyEJwsltNo8Ft5pDwy
         j8dYEZs68r93tzXRFm63Z6c5zJYZSdMkjkPqi11eaw/AP3CgE2ixd1CcjUbk8aUlSkpP
         zPNYtlRNtuG03yRkgo7ud3aFj9FsPNJD68IweJ+zZQXlexokaVicwjJKyLBKLNp4g1CL
         +DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xdFeUkMil+HXZ4ax6FoPNFtoFq6FUJmJ0Q6Zva1VrE=;
        b=lr/nocIizy7IrfwtyravNL5z6TqmhBy4oG6L31eivQEQmBPz5EY17jAieEME7vKfDk
         HjS5WIiqkjBISZuP85ALFWUg71JIns4XWPOC0yIuvYFe08CnOhNGKp2wGYT2rTKW3NvC
         4ppP9O2NW4t71xMXUkJ21G86CxkOhztGPK5jk8Ac1BZYqrDfNcmUIYy3qMCpkcVFMiPO
         D6si9Aik2+jmF9mRqVD/j+U9fs8wV0ii1owhsHvNGoDrTgZW6YmaI6FKJJ9B5jNx0L+T
         AMV5IIsD2M5ISnEoYq0HgR3GjJ14FGfU5h4dPSzm32KRmDa1Ikx+PEKj9BCdlu84PMVD
         xBpg==
X-Gm-Message-State: ANhLgQ1hcOeJ5+WcGB9V3VRlIFwS9UiH4DV4ePPXm4uMbX2nDURg1LFM
        Gow+qbOuHAAhcX/MEjqrjUPoOA==
X-Google-Smtp-Source: ADFU+vv2vW47TMHyado3xCQbCSqIX92ldURxbW69S9I1oeWxT4bL7zUy0acMpY+x/kqHktNpZ7+cSw==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr7994pjd.64.1584979048199;
        Mon, 23 Mar 2020 08:57:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c62sm13653239pfc.136.2020.03.23.08.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 08:57:27 -0700 (PDT)
Subject: Re: [PATCH 0/2] io-uring: cleanup: drop completion upon removal of
 file
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+538d1957ce178382a394@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <20200323092419.8764-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f98097a-b3f7-fc8f-4a84-f848253a0e56@kernel.dk>
Date:   Mon, 23 Mar 2020 09:57:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323092419.8764-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 3:24 AM, Hillf Danton wrote:
> 
> Kudos to the task hung reported by syzbot, and inspired by it, cleanup
> is made for dropping completion when files are removed from the fixed
> fileset. Another cleanup is also proposed for dropping the done field
> in struct io_file_put.
> 
> [PATCH 1/2] io_uring: drop completion when removing file
> [PATCH 2/2 RFC] io-uring: drop done in struct io_file_put

I like it - I applied, only changing 'done' to 'free_pfile' to make it
more apparent what it controls. Thanks!

-- 
Jens Axboe


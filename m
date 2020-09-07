Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8EEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 19:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A47521532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 19:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tPWQpPw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgIGTn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgIGTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 15:43:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B607C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 12:43:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so9065847pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6oyk7UyHJ86Ue6WLa0Z402qJDZy9lZz9Y0VEUrzUfI=;
        b=tPWQpPw2e1CQKEQZ3KsMYIXbn9FtEMti5vV2IhiENWBbWyE/xNIFhfg6jKEjRW+FsZ
         7QSRxiMZgjRoyLPmyZMOLVp8XWjj0QsfnjvZ5LOIf5N9VZ1nQUXM5LY04PVZnanuGQRY
         JlK9pkOa24F3UyzEL/51s1qMx0xd0E0ArzCWG7RmmWgdmWa0GW2bBpmCJuFtXwG06OM4
         AlOWZimuw70gZC9YGZmdhrtPg3v1kB6V6+cgouxv5YgrZHET5uKwM+yags7he2gDnQU6
         Mbadi7KUP3suNtupiTAttsrtNO/uDa/5CLDYZDhdJpczZHNAyWuX4g4EUUtx8wiGKkNc
         md8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6oyk7UyHJ86Ue6WLa0Z402qJDZy9lZz9Y0VEUrzUfI=;
        b=YFQtY08czR2Txmf4qN5ZYPJLAh5ufSCsElm5WDRbKojrfwXNHhsTtxTButhF3j6nA8
         UdyHvnjsKCqmuQ30huOFuOOqgzGUjN1w6aruMyM0VFb2J8KNeWTxsCWW3t1n2WNBvBun
         4I12Gsl0H+vWro/QwSvkhaPKynRGKczlupfQrRGiFcBq6BdeDu4Fs0UtmsR5yqaJg1N4
         CbXBJceji6Oze2eaQTx4Y/ReXFYumxUCyMA4rgKIrmO4BA7cRZhPBGQGYFyRKuxjlIVn
         UN+Sa7b5jbxk18BKPW5Tn2c/AVw/Qj7vDW549wJQXe1nPhdaPF6y3b/VYtK8VS+j9Fz4
         cV3w==
X-Gm-Message-State: AOAM530NaE/fjFpIRCdexGYYmQ88Jh1vxMtv3MlUaY0YJxlACC/ac21E
        ImJStGZXIBgDheIB/EN4eaf3kYnUpPmt6D08
X-Google-Smtp-Source: ABdhPJwwfzjrLqlUEEjMkHC3/aU1gERrxpqwrUDMBIGZTwj/n+jqsRBQ28klhPaAqo6GSK2BZ2b3Ew==
X-Received: by 2002:a63:9d82:: with SMTP id i124mr17611758pgd.336.1599507800895;
        Mon, 07 Sep 2020 12:43:20 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a23sm11429844pgv.86.2020.09.07.12.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 12:43:20 -0700 (PDT)
Subject: Re: [PATCH] fs: align IOCB_* flags with RWF_* flags
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>
References: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
Message-ID: <4e51e236-f996-feb1-1f8d-c94b4163551c@kernel.dk>
Date:   Mon, 7 Sep 2020 13:43:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <95de7ce4-9254-39f1-304f-4455f66bf0f4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 12:08 PM, Jens Axboe wrote:
> We have a set of flags that are shared between the two and inherired
> in kiocb_set_rw_flags(), but we check and set these individually.
> Reorder the IOCB flags so that the bottom part of the space is synced
> with the RWF flag space, and then we can do them all in one mask and
> set operation.
> 
> The only exception is RWF_SYNC, which needs to mark IOCB_SYNC and
> IOCB_DSYNC. Do that one separately.
> 
> This shaves 15 bytes of text from kiocb_set_rw_flags() for me.

Al, are you OK with me queueing this one up? I'm fine either way,
obviously no dependencies for this one, just want to ensure it isn't
dropped.

-- 
Jens Axboe


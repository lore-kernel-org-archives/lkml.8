Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D05C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B3B24683
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fgqd9Gs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgARUpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:45:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33530 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgARUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:45:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so11379350plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cPDaiuuezvQHY5FbiMneb91VHbFptyeIrZbpDAf5ezI=;
        b=fgqd9Gs3tFFWeije8getX63o/kmBD21eAjCYfAYviID4Tuyxa57QscYlsxwphjMrTL
         0cs8dBMtPWoQc5hIVzdwMwzH/QnfCn9vaI2jcVokoUFLHSiwJ4FAK5uDTH41On4NEKGR
         FfgWEcGWokyqh5HvVWh4WwIA1Cb+QLsByoRrczvqxfxC0rYToNlviLmDwuEdZraJHRm4
         WStqUrzVZa2Sfc2FcapQBdm0khNTL9zOxM544iIMqGuKbcaU1jaqJR+NXxDgrArcgX0A
         r79hUg3t2xNlRTPBmkDbkilG9ZwG+fblXlCjVtnO9DtmX9jUk7YjrFi0SeBDfgiCk7BR
         KjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPDaiuuezvQHY5FbiMneb91VHbFptyeIrZbpDAf5ezI=;
        b=Dk50tw12a+AO8s+foR1zlnKtsN74/lR/TUQ/aeN5T+TabSbOuZN5oGZCmxp/gKexoL
         LfA/EdfoFNVcN9RfFSOl+ypysmxzLQVJpv8fuduiN0jueu2+4Oay3DXi0PU+mW28Vu9G
         wLrSwN/MB93AIJ3NrIUCc4pl7brla7T2tPhCbKSKy9bNlcwo9ANG3e0j5aC7p0wHtTcf
         tHnyt8Vqmlo11eLdLSQA84ql2oUDCxkH7YdtDyTCGlCz7rXcWYVtg8B4b80M/znL09gs
         X72XQw/vexlTRpXK0oVveePq7H0rMig1hPocBSoERZ+dl7n93blXQIXohVuqL5I4AG9T
         Gnrw==
X-Gm-Message-State: APjAAAWSRQEYRvS8j5pelLQqa67TFToOCjDwxgU4qWpl4ZNwsOHptY5a
        DhfFama11iOKWboKwBhEgPjhGud82B4=
X-Google-Smtp-Source: APXvYqxdZFc8rUKvnYBdsfaCbtZU51j/0ksv614dOtS1iFCJC1LjBpRoRpa9DRX4lVO2NynxWQU7lA==
X-Received: by 2002:a17:902:b701:: with SMTP id d1mr6647046pls.280.1579380315182;
        Sat, 18 Jan 2020 12:45:15 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v15sm12050145pju.15.2020.01.18.12.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:45:14 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: optimise sqe-to-req flags translation
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b507d39e-ec2b-5c9f-0fd0-6ab1b0491cad@kernel.dk>
 <06bcf64774c4730b33d1ef65e4fcb67f381cae08.1579340590.git.asml.silence@gmail.com>
 <b773df2f-8873-77f3-d25d-b59c66f3a04b@kernel.dk>
 <ad7c75c3-b660-9814-e3fe-ef5a3acd7e8f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b358b578-f0bd-8886-a75b-b9caefea2496@kernel.dk>
Date:   Sat, 18 Jan 2020 13:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ad7c75c3-b660-9814-e3fe-ef5a3acd7e8f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/20 10:10 AM, Pavel Begunkov wrote:
> On 18/01/2020 19:34, Jens Axboe wrote:
>>> +enum {
>>> +	/* correspond one-to-one to IOSQE_IO_* flags*/
>>> +	REQ_F_FIXED_FILE	= BIT(REQ_F_FIXED_FILE_BIT),	/* ctx owns file */
>>
>> I'd put the comment on top of the line instead, these lines are way too
>> long.
> 
> I find it less readable, but let's see

Well, the monster lines are unreadable on an 80-char display... I'm generally
not a stickler with 80 chars, if a few over needs we don't need to break,
I'm all for it. But the long comments are unreadable for me.

-- 
Jens Axboe


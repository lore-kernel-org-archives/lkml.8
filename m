Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8407AC38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AE121974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 09:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urIkt/9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgDSJXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 05:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgDSJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:23:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC43AC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:23:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so8183607wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UdyUdSW1ErJ1sElWqPc011PRfio7esFxjS/Km3qvG0I=;
        b=urIkt/9STP283VXro1YX6bE/Tjw2e0+xM5LL0yYDlxCuudFZPlMm7xvAdTV80SyCJD
         s41QmoDr6wRN5mCjGr5PEIoywNUxoYMku4DajUBRxUCIxAcbTwfTHQUJOcehXra5DV5w
         BMIs0wrY+tynpoaoZQZlwhJOhVzkj+aMEGN9dUYVAuMtoNbDa9CXTOv9TsXt2sXx23cv
         N19VIdO4mwkBJoEZZ6gGZFNQoaVEtSItyYgKEJ4F+TSCMbj6FJnP7zDeZBVCxrL365u/
         yFzgBGfw6LSKLKdpz37FnVBEyvEaty4E//m8isB3WP79DyY/jff6zTyBBHqEknush/Id
         z41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UdyUdSW1ErJ1sElWqPc011PRfio7esFxjS/Km3qvG0I=;
        b=dPhzohNhQpEPpmf8yqJQEp/D0TQ7uM5B1MxBcA5PtuKA9l5js4ZxqTjWJHbJ15Bo7p
         ePqUVr8QiAK0euUWm56be1s/ndabE1RDm6F9GpVdoX5Pr2Cryx4kggXXofkxOZsUzB5P
         4ze7OI9DJ2pCikCwZ/F1rdzV2W6rMLvRuVpM5DZw4Kz9GevRoCjSVVHSCVz46L9Jb6cp
         UuJVp2Ta55dABGK/jsIpRy6atIRNnh/Xo6+Rq3RiIuWCd39VE32zxdkNWQ0syggRzDNE
         /GItbrkVTOXntMdiDyvcPiMmsmt8wVOhi5NXN1OztJvswYTgWzb7Se4Cl4OV4Mn6vacg
         D/pQ==
X-Gm-Message-State: AGi0Pubzl/6CAQVaTVxVIuSNqZ9Zc9zkna4WsKvHgDCnZ1kJXOSO8L1Z
        JmnFfm4ci096RR3yr4R8Wb0JKfQ8
X-Google-Smtp-Source: APiQypL+N4qWWrGUmVNoRGX4XnqDBzYU/AYGhFMaikBa5miNgA3ld4fap8lKryI2GBSCQYMO9xhRJA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr2836782wrh.410.1587288178362;
        Sun, 19 Apr 2020 02:22:58 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.57.threembb.co.uk. [188.29.165.57])
        by smtp.gmail.com with ESMTPSA id u3sm29420682wrt.93.2020.04.19.02.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 02:22:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: vt6656: Fix functions' documentation
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200418123659.4475-1-oscar.carter@gmx.com>
 <20200418123659.4475-3-oscar.carter@gmx.com>
 <adc4bc72-5c80-e8f4-8d48-052109ae18b7@gmail.com>
 <20200419074717.GA3244@ubuntu>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <42190e0e-4167-3cd6-0e52-d240ae67a502@gmail.com>
Date:   Sun, 19 Apr 2020 10:22:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200419074717.GA3244@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2020 08:47, Oscar Carter wrote:
> On Sat, Apr 18, 2020 at 07:05:53PM +0100, Malcolm Priestley wrote:
>> Actually I don't really think the function descriptions are needed at all the
>> names of the functions are enough.
>>
> Then, it would be better leave the documentation as it was before or remove it?
> 

I would remove them all except for comments inside functions.

Regards

Malcolm

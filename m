Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E1C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28AB21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9DcK5Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDRSF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 14:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgDRSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:05:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18668C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:05:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so64237wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O4U+IPm6wwBCRpajIFNeENCy2/QtAFa0dBn73KPuzS0=;
        b=N9DcK5Q5c7dscVTCmHncEZHvn9QX4LIQaYHTtnxcIQKGlCtdhSrUgAhl0wMSl+iurf
         6qigTMAIFf3Yitgkkd+sYYo6Fh30a+MNeVvFsP8AOi1DSiiu2AUzZbyAzDO53C+M7mPt
         2PXCZmav3ZFOA41sUWI26R1eWAkpMX9btDsJAlucku1yMp0dZvvu8ehgisWPK9DwuvO4
         uTwVoTSvll/dgvx4vbUyVpc2D+5o7VPOzWn6KiSr+2CkGQwnREuI9xqOJ70CUnyaf7Gb
         Q1kQojGVlpukIr2KkNux5t4b3whWlEIRZi5LOcsyeeGI8OV9k3P+aylBTRtuHEIgUlak
         q5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4U+IPm6wwBCRpajIFNeENCy2/QtAFa0dBn73KPuzS0=;
        b=cOf4AxF1r05orPOylkhwGqltEy0qU8IDlkq4piSuA2twE5vsMh7awkBFhxYGZhwjAs
         vJd1Ci2tpMeMlclGrX/K1p7vPV9OwTfaqO+81/WZlA3v0xB8WuWijyuuemzzzppG1rR4
         Iu+Q8++wDdjx/EZ5iA7r1bX5/jJoPqkAykxi7Ma6FprGYslXkj21/qRZr9OzuZgFR8lJ
         jsIzyHnV1h6GAHq7DmudbcU3kZ6BKjmSMmDspF7F6TpdvddQTengGVp8V4pF/Rg598Ge
         UgqzCPThm36gTTevpY8P5m9w/+bh9bf08W91lG/9XTqdpkQUXe9v8w8r1/FEIX4nLUF0
         dPGA==
X-Gm-Message-State: AGi0PuYNBXsPWATPRQhJGHV0zIi+lc6W1ScM41+ttCmPOvvS9W8R0lLg
        x0YfiMho5MeRhqiVbYTQWLsddxy8
X-Google-Smtp-Source: APiQypLoEkLQ5045RR7fd8D/nO+e0Qs985sAMMqOSmX3Xm1GzaQ8OBi0O1N4jaHnsPyR1rgZQ9001g==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr8755746wmg.109.1587233156597;
        Sat, 18 Apr 2020 11:05:56 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.57.threembb.co.uk. [188.29.165.57])
        by smtp.gmail.com with ESMTPSA id l19sm12514363wmj.14.2020.04.18.11.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 11:05:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging: vt6656: Fix functions' documentation
To:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200418123659.4475-1-oscar.carter@gmx.com>
 <20200418123659.4475-3-oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <adc4bc72-5c80-e8f4-8d48-052109ae18b7@gmail.com>
Date:   Sat, 18 Apr 2020 19:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418123659.4475-3-oscar.carter@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I don't really think the function descriptions are needed at all the
names of the functions are enough.

card.c needs to be removed the bss callers to baseband.c, the tbtt's to power.c
and the rest to mac.c

Regards

Malcolm

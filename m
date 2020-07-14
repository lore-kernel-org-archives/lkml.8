Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394FDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10ADD22470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594741775;
	bh=m8ZRITMS+0UsFY3d2kWWVunZaKKwKRhRdIa7BODJcuk=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=t547N3rXnutzrjLfnQZxBRVglbOBCGCq/HUVoi53GcYQbkhu5IDYegT501oLn+dEC
	 ErDjhF4gkE7a8Tw1aHpvw5NmWD6jPEY+zn1y+EnNUkWlvDu8tcYaVzEx8hayIw3CcQ
	 aDJ3zcpnKoKiFHZUV/QOlhBsoT+ECow3dht4vVJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGNPtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgGNPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:49:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AFDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:49:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so13370804otw.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6jLgbeQbR2y51QxkPXj1KM5ydm8hN4KlBS47bVAqPbo=;
        b=bDY4rE0dt2u4c3T1MoOhMWAfTGN7nds8Xy1K6CacPGA+PTYOPZUtoy+jVY7bgXOfGC
         qYpoFE8UJIdMqcyVmbdu4AdSAKLJS8DCSLEJPAIB72/KgXJjGINSdllY1z4R9llJ+YEq
         FMMKB+CPbWzO60nbUhygXFx9+AtcKVLPBCoQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jLgbeQbR2y51QxkPXj1KM5ydm8hN4KlBS47bVAqPbo=;
        b=rCzdlQlLwMlltNXlYBAW0HwBYn2bPJig9byCNCacWV/geLZ8EGccBQv5B7a5qAR4Ia
         6QsYcQtXRYVQADuuRGLU0r1lsOICWigraF2cCjVDBs3bJY/sP6XJt4mB05Rvj2HHBXGd
         ecmzhWZOaBSvDJtNowRBNOSTX1ZaxVXt98HowllT9/isMGUt/rS8+Qp/+GHhwbggVOCZ
         nFe2okIk2FNoibYShKe2Cp5Htl4w2J9G7WZHseuwXrdxHFrGU9jhkVSpDQrWO81H/42g
         oq4IUHCzyzsfCPQi0JUeucPgr2r9MNUQiZ7JCQjjEI7Xao6uKQHHipLIcG61sbU8oFX4
         Ek3A==
X-Gm-Message-State: AOAM530o3NqsykoUUNbOkpZ2+nXNf8oRrg6m5ZYqR9sK705uUAR+HF/y
        x6HXfzpIJbqQrpPoLjA0CrAL8w==
X-Google-Smtp-Source: ABdhPJyiHPS6sDocyBlmPwMcOK3T5OJvhc9vK7owfgslvoVxglvfp5im8gyurA9CgafUTZMNcrKmRA==
X-Received: by 2002:a05:6830:198:: with SMTP id q24mr4675315ota.202.1594741771493;
        Tue, 14 Jul 2020 08:49:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a6sm3653744otb.8.2020.07.14.08.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:49:30 -0700 (PDT)
Subject: Re: [PATCH] tools: usb: usbip: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200711062442.GA2784200@kroah.com>
 <20200711123906.16325-1-grandmaster@al2klimov.de>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <55e97454-c376-e640-f020-cb297e176681@linuxfoundation.org>
Date:   Tue, 14 Jul 2020 09:49:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711123906.16325-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/20 6:39 AM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>              If both the HTTP and HTTPS versions
>              return 200 OK and serve the same content:
>                Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD0AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DF1205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589389755;
	bh=KI/fO0Z64wCimf7pEura1WKIJDBwAbEnN9Vg+v9jZ3I=;
	h=To:From:Cc:Subject:Date:List-ID:From;
	b=t4Rc5/bTxwX5fhS87g2CvWTjdzYL2/E8q50vk2/vB4wcBLSoXxDgufATZjQud4Op4
	 p8Tt9t/Im7eqVj47UWBFpeeaUaV3mXZk4a/8+4bi7kKYRnonmo0GK136YJHKVSVPyu
	 PvgC0wPmDheqmQ/1VZkRHxKZ2fVp0+zstvQJuDNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbgEMRJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEMRJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:09:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3107C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:09:12 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l20so369858ilj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OTwSFldhDgwfKavCOIqhkMtsv6Uf6dH3DgyIcps1eeU=;
        b=UoFwJ9P6t9qDrTAAi/bsDKZIYtkB3BOvVi3IZm4PBCwU9m/CWIgvpZHwAtNVrcsuBY
         VzkhnJUppqGiGUb8UBnF+yGIIn7MJ2nBDzvTtFkDQbXqqzQZMaodIo5rIcfIcQ9ZPwJI
         TrXHmQSzYqCHcF9yf7jkXjt9piz+fao1PBF9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OTwSFldhDgwfKavCOIqhkMtsv6Uf6dH3DgyIcps1eeU=;
        b=SM/y+ySoLoGcapb9eQg/qvpE0xjvWlXBKKgspjbAstLqgMHagYIsP8ZhGL9tbusFc2
         Q9QihCh9mkcTO4PAEglmUGy3GPKDsQmOpuACj6EpBqUjbqOaTT4VrgJy/cFpyLWyJQT7
         pnd/KdNT+Ywi9RZoeR8Gv4ELqRwPdHjoB/Ds3sqZ6kteC2JmBDSdd54llWzXvd+XP9NN
         QFMdr+15npL4b2yfxjH3Y6Wmt9x0PBvE5wYFkRkhPRCtSCZet432Sl8sssYsjA3do/0J
         ifBJZt0L/E347y1EOMEnub6JCa2NN1C8YuTqArW6cPIZboalJWmm4SrkSwOF8TUm9T+C
         accw==
X-Gm-Message-State: AOAM532fd7QrVk+1ME+rtIZxBu1QwhcoXZHoVVP2mC6UnuyMFYplhGF5
        d4Yr7Nlxz3vQnv4SV1RPqM2WSA==
X-Google-Smtp-Source: ABdhPJynHhzvyR2M0NLPpd7dWtvx0skkR3CAGs3ixp/82ITq2HUgE8/zq9IrmNdukPRZ1FYPD56CLA==
X-Received: by 2002:a92:6c11:: with SMTP id h17mr487372ilc.178.1589389752280;
        Wed, 13 May 2020 10:09:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k11sm97413iom.43.2020.05.13.10.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 10:09:11 -0700 (PDT)
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jukka.kaartinen@unikie.com
Subject: [ANN] linux-arts v2.0 update
Message-ID: <0c3bb5e9-d372-782b-2499-41ee61080c11@linuxfoundation.org>
Date:   Wed, 13 May 2020 11:09:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-arts git has been updated with the new reproducers from
https://github.com/dvyukov/syzkaller-repros.git

- a total of 1138 new linux reproducers
- new script to collect reprogs from file system
- updates to README.md
- Updates to README on how linux-arts is synced with
   syzkaller-repros.git

This update can be found at:
     git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-arts.git

thanks,
-- Shuah

-----------------------------------------------------

Author: Shuah Khan <skhan@linuxfoundation.org
     linux-arts: Update README with process information

Author: Dmitry Vyukov <dvyukov@google.com
     linux: add 170 new repros from syzbot

Author: Dmitry Vyukov <dvyukov@google.com>
     linux: add 270 new local repros

Author: Jukka Kaartinen <jukka.kaartinen@unikie.com>
     Add reproducers from local builds

Author: Jukka Kaartinen <jukka.kaartinen@unikie.com>
     Add script to collect reprogs from file system

Author: Dmitry Vyukov <dvyukov@google.com>
     Update README.md

Author: Dmitry Vyukov <dvyukov@google.com>
     update linux reproducers

-----------------------------------------------------

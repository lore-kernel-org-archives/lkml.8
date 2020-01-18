Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334CC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355772468B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giklA9pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgARTUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:20:23 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:45934 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgARTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 14:20:23 -0500
Received: by mail-lf1-f44.google.com with SMTP id 203so20875114lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UZm6Tag438/RN9lcYCGvGRdSS8+GAe42odyAEtSG3Pc=;
        b=giklA9pmt6me4dBgboCreAAn6rrMRyWFWx4AWFRfZGx3+5ZQGuv8nxY58vM0xDtFqt
         K6ZXy6/0EwjZIE0ntILcBR4B6nglg/koy/4stikTC+6lv8btlXdlgOTs/LgtLYR4vu9T
         ElTtP2FN0ze83j9QdtVgvb+MOvd5ka8eXa18jt0l0omJcHj3IifvVe9C/m1xA0WXokWV
         O0bULEKD9QSRlx+PwBTN5FQLXee5Je6Sskd6qDEHv6yUQpRO7u1u3NbTzWur9zs3iwv1
         Sbruod8Elealyb2oyd7etzZj17Xr7+FCGGhdnPYXv7lpLB78Gh3MbZeI4MxnmU/lb9eC
         tR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=UZm6Tag438/RN9lcYCGvGRdSS8+GAe42odyAEtSG3Pc=;
        b=maMSavR+oc2tkzsclWz16vi0dTEoX8Rp/1bKun0hIFkFNFOzbyd2pcZPuTKyZXifwf
         Ln7OhxagSsNw6zgjPKDXH6oSr2lSaTaUFJyTc/bKOSDgayc+7yxvPn2ruwiRBmClNTY1
         SJ3ePR/BMwVzTLd5R2cI3AHLTZSsbdagjQLxl2oALMBS7NdgLPYGK1sfhLm8msOe7Lfe
         xkiExdTqD1LhG6vxH6UdKHyJi5M18jrkv+Et7Z60FXq5nXZSywoe3n2jiAx0hBQRn3ay
         8ZKJi2A0QardwjJQcova1AbZj2noi5lSQkCunviqJYT2CzKVzSaqpERY6Lf0fMPypQ4B
         rd1w==
X-Gm-Message-State: APjAAAUwgDmxfSn+26HPsuqXapjElJTCBLts6MEg9tz5o6Lav8PTY/QV
        zYapmUFcormVjxko2TaFzvSb61XP
X-Google-Smtp-Source: APXvYqxsvCPZFFJ94Q+cC8EqaBPYfp2z+nAxRkOeSdXvAzeY6x+1ob+mCnLM/DvLwWoNBAdp1Bit1A==
X-Received: by 2002:ac2:531b:: with SMTP id c27mr8847490lfh.91.1579375220510;
        Sat, 18 Jan 2020 11:20:20 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:af15:a51e:b905:dd2b:45cf? ([2a00:1370:812d:af15:a51e:b905:dd2b:45cf])
        by smtp.gmail.com with ESMTPSA id n11sm14244109ljg.15.2020.01.18.11.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 11:20:19 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Stuttering (mouse, keyboard input, video) in 5.3/5.4 when swap is
 being used.
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <4dd4d78b-3bc5-3fd3-d44f-c1e259537b0e@gmail.com>
Date:   Sat, 18 Jan 2020 22:20:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently Ubuntu released kernel 5.3 for 18.04 LTS and I immediately
started observing periodic stalls/freezes without any change in my
normal usage pattern. The effects I noticed:

- mouse is frozen for couple of seconds
- keyboard input is frozen for couple of seconds
- video freezes for a couple of seconds

After some searching and experiments all those freezes look associated
with swap usage. To make it absolutely clear - when this happens there
is *NO* memory shortage. The situation is really - as soon as _some_
swap is being used, I start to see observed effects. It is enough to
have several megabytes of used swap for this. I have a lot of free
memory when this happens. Like

              total        used        free      shared  buff/cache
available
Mem:           7.7G        1.7G        3.6G        419M        2.4G
  5.2G
Swap:           15G        218M         15G


This is trivially demonstrated by removing swap when stuttering is
observed. Without any change in workload stuttering immediately
disappears. If I add swap back, I again observe stuttering as soon as
even minimal amount of swap is allocated.

I tested also 5.4.13 which shows the same problem. From practical point
of view it seems to be less eager to use swap, so at first it looks like
problem is fixed; but if I force it to allocate swap (by starting
several VM as example) I again see the same freezes.

I then went back to 5.0 and problem is gone. No matter how many
processes I start there are no freezes. I do see obvious slowdown due to
increased disk activity as memory consumption grows, but this is expected.

To me this looks like rather serious regression. There seem to be quite
a lot of posts about similar issues starting with 5.3.

I understand that all this is pretty much unscientific. I am happy to
collect whatever information may be required (including compiling custom
kernel).

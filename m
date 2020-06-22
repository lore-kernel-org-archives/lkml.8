Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D5520720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="VAmdyUsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgFVLuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgFVLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:50:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049B8C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:50:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w6so6364248ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fH4rNdOd/0DtPCmm7DTynSkeo7LxPbR8dmKw5LybOyU=;
        b=VAmdyUsdN2ivud7I3BUybzNsHUoWtcliplXD1llq7mJ8rXj6Yo00x/zDCgoW7dvJeV
         bhrmghsAG/kmbv4PKQNP/hIEvYBKYjzOlcxtFTHzuS3ulJEruyYSfW1tK/X6fno65QdL
         qnfg0dy/L76P/M9ECK0zlhiG8aheuE+2YUtCMJTyr3n5plQwKFuw3oWCZYwcnuuqxsgL
         7q32ZjqiNBAVsBojvHKsSkHZ7gAs6Pqa8lhXxbjphHS0h//reFYJvRb03tU6hsUe8HqA
         YVrWpKm4Kms6Vt9bS6CbNfD9kNhp4T1vii7iuR0sP9gbCfcvSwHb0lSkH/j2kbiQK3Dk
         uhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fH4rNdOd/0DtPCmm7DTynSkeo7LxPbR8dmKw5LybOyU=;
        b=GsnTR6Rb++sQ2Ythnjlh5r/WoSgOr3sTSHxmhDZr3bQ/nx6OukOJrXmFuMZ/p+A5Hc
         odvDpwdjAkkHRwPbyv4/dKFwr9BKWY1cpFpvNidV3dJt7axC8x4UFfydZ223DirQg3UL
         1yUYoWaDwMEqDb55zQpAyKMJkWXq3gLV/d2qv+94hPYDebvVXL8fzyneyOHf+x3DAkee
         gZcBNUzyqpE/0mzvq99be/WvOah0+LTB4xJUVmnWveLYfgGRsH73RT2FG8fHw0RWuuLW
         4ScAp2ISju8nd4NVmTPx+KQI4zJOC14Iou6QKJ7bEBOUT/QaqfFnrzUIDKYZzknxJsWL
         s+EA==
X-Gm-Message-State: AOAM533UTDJ4QMwjC4DUIBdLK8YRDtJAddK8NcuaMV6kSj8ee+aGO/TL
        cwI8LieD/2G/INpt9DN8I5K92t5l7uo=
X-Google-Smtp-Source: ABdhPJwefaK1G+I1piFrT60Nt4bNSd1j4DovkLJsQ35G8yRg+d4lYAxcsGgWRNP18Z9VzsqIeGXryg==
X-Received: by 2002:a17:906:3c10:: with SMTP id h16mr9735413ejg.87.1592826601230;
        Mon, 22 Jun 2020 04:50:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s2sm12389468edu.39.2020.06.22.04.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 04:50:00 -0700 (PDT)
Subject: Re: [PATCH net v2] mptcp: drop sndr_key in mptcp_syn_options
To:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
References: <60f8315d6ae7b62d175c573f75cee50f14ce988b.1592826171.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <1c0f6f37-ede8-b341-f274-2b65b17dc141@tessares.net>
Date:   Mon, 22 Jun 2020 13:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <60f8315d6ae7b62d175c573f75cee50f14ce988b.1592826171.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 22/06/2020 13:45, Geliang Tang wrote:
> In RFC 8684, we don't need to send sndr_key in SYN package anymore, so drop

Please next time try to have max 72 chars per line in your commit message ;)

> it.
> 
> Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option according to v1 spec")
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for this v2. It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

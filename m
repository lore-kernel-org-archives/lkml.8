Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F23DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B420658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO0yYGQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgG0IHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgG0IH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:07:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD9C0619D2;
        Mon, 27 Jul 2020 01:07:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so16192347ljl.3;
        Mon, 27 Jul 2020 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QBY+w6jlyOsmPmSWdAT4jKigsszPSmssReg15Ky49UU=;
        b=pO0yYGQCSTQKbT0MGpMhARYtQU/QS+0eHydoie2QLOig4M7Wwlc33+Ywk7W9mH1iMQ
         oAUuHrynvVNvmmbF+k8N5B0j8+maV4Wn+MMIuXuxcXmBYtPtBwGDK7X6++E5EebQkd8O
         g9DZWNBmfNbewt0xugznCCNnRCuL2u3UVzBv/R4Zu4SAiPnHNvI13/XNX7oUcF3Kzs0f
         490YLr4rsAyv5QkH2FySa8u1/4vZugEYa8xG3LFW+GpfG1zFg9SetYLUes9Sfe9Xukli
         pv8+nz6+btJpWeL5P/pnh68uiC7AYJCSCCFKuJtwxeAsOidqiGxeU9vW7SSq010YLTk2
         GbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QBY+w6jlyOsmPmSWdAT4jKigsszPSmssReg15Ky49UU=;
        b=V75b7BpvAOd4p1KGHWkdXBqYjvXXUE9+PHnSOj6hondqUdzRx28Ia5OHbQODf2ux5P
         X4CRnWMoWyKQxUGcUKoIG7Bo0LI8hFwOpjr+eZR1haEHOu6XMpwSTGZ/WUQlzrEf+gKC
         HPS94mTfEzGDSKX26+sHRdj3GTRuiOBOtloPzrrZizNCaP9fLz+Y0gAp4nc72Ue3WLsl
         4r3SplNDPcuepnumWO4ogPwc5ogXtjx0RlUngW9XJ34QUrYjm9cP0n3Rb1fz5i+on2s4
         OHfB7zOuYhTcsSr5OPchKWeGhXze9xp/cEu399siWfmlGm11xynz2B4tuxNPFPkyg1BF
         PstA==
X-Gm-Message-State: AOAM533GBqoCHKETkCmqZ+K6L31mewn+fkAmNdf1AnfEuWjRcM7SZx9w
        1FRgW+5pR2tCXq1Sa5BXYKs=
X-Google-Smtp-Source: ABdhPJyp2w8n0TkWqz8Tn1BMhL1Hbci2VJ8g3DYVzcr02L4rjMmleq2Q8xI7QTOB2HipNAT8vnpsPA==
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr8963831ljg.132.1595837246293;
        Mon, 27 Jul 2020 01:07:26 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:2f5:268:51f1:5041:2d6d:a8b7? ([2a00:1fa0:2f5:268:51f1:5041:2d6d:a8b7])
        by smtp.gmail.com with ESMTPSA id t205sm2861608lff.8.2020.07.27.01.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 01:07:25 -0700 (PDT)
Subject: Re: [PATCH 10/11] usb: mtu3: clear dual mode of u3port when disable
 device
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
 <1595834101-13094-10-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <e30483ff-e66a-1cba-e166-a1fe590c2f03@gmail.com>
Date:   Mon, 27 Jul 2020 11:07:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595834101-13094-10-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 27.07.2020 10:14, Chunfeng Yun wrote:

> If not clear u3port's dual mode when disable device, the IP

    If we don't clear ... when disabling ...?

> will fail to enter sleep mode when suspend.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei

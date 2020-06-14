Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDABCC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE7320747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFyvHa5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgFNEqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 00:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgFNEqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 00:46:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B785C03E96F;
        Sat, 13 Jun 2020 21:46:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so6302344pfw.10;
        Sat, 13 Jun 2020 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RWwMRynk2fWdB68I9OsS843xaUuoJpG9P0IWOTWPIPQ=;
        b=kFyvHa5/Bsyox+RGrqADQP+tdG3Ar2RdEnYxAto7xASUR/5jWsX3IWuPdu/ez9RjTA
         8TUqZoC00mnsm7jnmmPTrn/FTcdiOQhLc9AdtxapTewBI7ZEyX52Fo9t2dPWf6Pzg6CO
         cVgsqgc0M+G5Z8kuMgIyzws5RN9ixB/vccDV8ko1JwVMr8nJyWP4iTGWVJHyrbDLbmJG
         Mv47x7rcNlSI5oIkiyCZ7A9cjQR2zstmxz26Bv8jL8zuuD7SJJUSKYx2JHuK9K0BLMq7
         gPeRRC09ftYu7ZILInNJLWdSMHo4cSEPAsAZ7S3yiCADTsyDXLIUYH1lLWiWJvMt1TQp
         rOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RWwMRynk2fWdB68I9OsS843xaUuoJpG9P0IWOTWPIPQ=;
        b=QhAG1lmIgS0v9zzzOqiYh8nvzGZUvHrWyWLzSk5QnuXh9fUfk+5DKBKWf0DLeNGQl7
         U81DQX/Z/XXNCfTbgfCXiN6N8ZR7AxGA3TgCWYXL9XbP8HxKtWOlL6daMp9tUyJtmWIe
         QC8hEjhjP/gy0rvdJpi8owcyWpKeYhX3dx+akuv5DtGj7j36M0rQX4ikmlsEYrWlHEK2
         P4Jus1ZfUUhfdgJ9Ge2zaAef6Pf5yY5vzHWt11notQfwYTQ6GvebeO60Mu6pajVBjuq9
         iujXS0WVVPAGRFHvpdMN44vfoZKiMa1PQycLVpyCQ44jg2OPNNQWfIBMJgI1F57e3fyc
         hHbg==
X-Gm-Message-State: AOAM5300ZVeX5b3aXFphbjxstyqnoW5U2s1g0tML4ERI2arDyvFot1G4
        sSx34mfm+3iMIw54UkIOJrU=
X-Google-Smtp-Source: ABdhPJyIL+FOuFErMkqtDiiJShhFGy6HX+YtfYQkkmfnuFY+L1cs+L9rQwTXj9KW7DAQ5VjsLj7zrQ==
X-Received: by 2002:a63:5f11:: with SMTP id t17mr16163082pgb.177.1592109997105;
        Sat, 13 Jun 2020 21:46:37 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id 131sm8727305pgf.49.2020.06.13.21.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 21:46:36 -0700 (PDT)
Subject: Re: [PATCH v4 4/9] mips: bmips: add BCM63268 power domain definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200610171630.465579-1-noltari@gmail.com>
 <20200613082140.2009461-1-noltari@gmail.com>
 <20200613082140.2009461-5-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a3fc149d-f2ed-bae9-4737-6f4d52025e6f@gmail.com>
Date:   Sat, 13 Jun 2020 21:46:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200613082140.2009461-5-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2020 1:21 AM, Álvaro Fernández Rojas wrote:
> BCM63268 SoCs have a power domain controller to enable/disable certain
> components in order to save power.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <F.fainelli@gmail.com>
-- 
Florian

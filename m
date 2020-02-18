Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7AC34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D16420836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfe5YN1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgBRBAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:00:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43093 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgBRBAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:00:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so20904726ljm.10;
        Mon, 17 Feb 2020 17:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N3Wa2BGzPuFtAt4Hvp1UfThMFJPTB2GMc1k1np2GKU0=;
        b=sfe5YN1OtoDO+kekL/Xz4/fWFMfVhU6pzKL8YOgzJQD3luNHeLeXmr+NtbNbHzHNfl
         h18FQuBh6ucdum9WYBnUXurSnMOIOo3TblCnfNS/ccQYsk2SJvl1IeNKXGYG07FV6+bR
         cfi1uJFeJeqzQ38t5O1sa1j1E/kOKKvT8WZ9BP+uIh6Gq3x1u2fO9QvV8hIXnS71uzqV
         ruveI2mT8tKWW5IvQjlppD2rsCGC9WwkGeVAglKs+Wj7VFhSaIJO2Vsqbh/ZHWcyj4M6
         DXJhh7TexQlxvg90SIt8vXVqe14SKpbTmey9+55/e/D4Q4jD4vz+s5if9U/ErQPfoFS1
         I7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N3Wa2BGzPuFtAt4Hvp1UfThMFJPTB2GMc1k1np2GKU0=;
        b=H/TtYOP1s/PyW3CV+0ajl1LCj2PztoKmhGn0QMK1EJ5+7pn/MT0mEzzzab2TjSUqEm
         FkIzc5h+B+ess4Q577JgjVQcsdq7mQosHf6DJcoPkCwJUHYEwjUikG47f707o+f8C35H
         j+FuedvXVuZfm+/SKV+eJFPhs+jnuFjZePYQzWspK0in084WAUjkBFXshFdSiATH26Vs
         QWFe8rrKLrGUYu8DeybjiyX9rzCQm10tePN3rpeOszEQNfGf0+S2THt3dGAqa7p+/tt9
         jDbIbKktE4FBSsqpXSnWODHaEUW7NA9tIV/vpau6/j79Yo0BFeVn/+ONxRZpphmMPFTS
         OS5w==
X-Gm-Message-State: APjAAAVP+/hDd003yMSylQrAJNhhTgvvKKCLy4uTbq2x0TtV0PUhPiao
        xsTnwwX0GGg10BqL4xh5HoM=
X-Google-Smtp-Source: APXvYqxl0e2saUaXkBe5/Mraz7tV+hghoh3F+M045Hp3wjrFqzmf1QxgPCmplNEo0DL99MdfIIB+4A==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr11565660ljg.108.1581987615650;
        Mon, 17 Feb 2020 17:00:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u16sm1315815ljl.34.2020.02.17.17.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 17:00:14 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Jon Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, atalambedu@nvidia.com, tiwai@suse.com,
        viswanathl@nvidia.com, linux-tegra@vger.kernel.org,
        robh+dt@kernel.org, thierry.reding@gmail.com, sharadg@nvidia.com,
        rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
 <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
 <598fe377-5b95-d30a-eb64-89a645166d42@gmail.com>
 <3f51939d-cf4b-f69b-728a-7eb99bbae458@nvidia.com>
 <34ac1fd3-ae0f-07f2-555f-a55087a2c9dc@nvidia.com>
 <1a84b393-938f-8bed-d08e-cc3bb6ed4844@gmail.com>
 <0fc814c2-0dc6-7741-b954-463381ff7fb9@nvidia.com>
 <b5c581b9-17af-d004-33fb-2cc782ab820a@gmail.com>
 <9f73afdf-1e9a-cdbd-f972-a022d503ef51@nvidia.com>
 <264d3354-8a2e-ee12-44ae-aff69213d551@nvidia.com>
 <075e476a-36bb-5fee-15bc-76af4474a797@gmail.com>
 <c6022a93-b79a-c691-1d75-d007d0b64ead@nvidia.com>
 <3b42c858-733b-0d17-f457-8043d97f5058@gmail.com>
 <62b8ffbc-aa32-ae44-6cb4-b176b8ba9b0e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <847739f8-6f54-cf64-54b8-94707944850b@gmail.com>
Date:   Tue, 18 Feb 2020 04:00:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <62b8ffbc-aa32-ae44-6cb4-b176b8ba9b0e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.02.2020 17:05, Jon Hunter пишет:
> 
> On 29/01/2020 03:41, Dmitry Osipenko wrote:
> 
> ...
> 
>> The !RPM case isn't supported by Tegra anymore in upstream kernel. I'm
>> trying to help to make yours driver better and gave you reasons to
>> remove the unneeded code, while you're keep saying that "there is no
>> harm to retain it", which is not a reason to clutter up the code. I
>> don't feel that it's worthwhile to continue arguing here.
> 
> On further review, it does look like a reasonable argument to get rid of
> this now completely. Like you see less clutter and the soc-core should
> ensure that the card is shutdown before unloading. OK, so fine with me.

And the RPM core ensures that state is synced on disable, sorry if I
didn't make it clear before.

+1 for less clutter :)

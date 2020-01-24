Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3022075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7VL69Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgAXE25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:28:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37398 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgAXE25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:28:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so301339lfc.4;
        Thu, 23 Jan 2020 20:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VLtJqd9n8iEGWWWwFYJk44IhKuekuFlbjkOOSjbK4Ug=;
        b=b7VL69Al4Q3TfIx5Glo4Lk/mg/RMvnYyJKH/l2Yzy5Oex07mnDpixdToqeCBQaoAWK
         B9nzH8IJcDmQd26XXA66TJkZfV7/u9aW1PcLZlg43tTjKlDt7O6av3JfuZa8oW+kOZbT
         PiSjuNcQh+X8/rsAroz+7FMrjT+mrpQBUdUGUxR4QvetWX9Z5OW+6b0vIZoky9V0BvZh
         14IHMkUS21cds/eS9GcYG3UndNtA+LoWyAnB9lw4IHvNJDW188GKTHaJ58/0Z8bY4J0L
         7o1xo3iI45c56/LRLxwcXsTcoo1Ys0YXF9MmCgeQ7+KWP+9bvL8b0DK0NiUxUKPRubbG
         5ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VLtJqd9n8iEGWWWwFYJk44IhKuekuFlbjkOOSjbK4Ug=;
        b=Q7B39cVfS0vwCx3Zntnn9BBFMyxR1B1juIpJ4xUzEfbZ563cPVsZVGPsBU2zhWIjAR
         sXQ0yGC5fGKz+R1Q1wvpCQFOix7NqoGwUaJ2WQYzYx+zYuoJ4+Q8GTBGCjHzer3cJA22
         Nk484F0dnOSnTYvdMLSid/CA/li+FYyXtxGad+9r21ev5Y5en6p7ivvm6lS+ZOeVd8Oy
         +RdQc3ndutZVb3URswFPv+fziYtfwhCqTK1UG6zNmBG+5xUeZB4NqXaXSIzuj/9VfzMh
         lTXEN32eplOKZ1efFIA7oXSK212Sp/Dl4m697HfSbzyLvA0FDCLpvkN8YNrEuB0JrAEj
         ZbEw==
X-Gm-Message-State: APjAAAVI2J4CO2RC+RXU+5Ci8wrvzKB9onVUVsdAmrlxpRn214QkFQZa
        kbB+dWRpMKhw5nweZ8S/gkA=
X-Google-Smtp-Source: APXvYqyRExhBqqvbAcTEoPhTfbxzuj7kgwI599mLqXvMCeAtJ/7luyFkKBpeGBOzIDDLGas1DcH8rw==
X-Received: by 2002:a05:6512:3ac:: with SMTP id v12mr496446lfp.205.1579840134560;
        Thu, 23 Jan 2020 20:28:54 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e20sm2302728ljl.59.2020.01.23.20.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:28:54 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 5/9] ASoC: tegra: add Tegra210 based AHUB
 driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-6-git-send-email-spujar@nvidia.com>
 <5ed7482e-e874-9e11-c84e-7418e4b5162e@gmail.com>
 <d160fa01-27d0-6290-cb16-07d159d6fbb2@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <37669247-daaf-c6cb-0ef2-464e61db9838@gmail.com>
Date:   Fri, 24 Jan 2020 07:28:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d160fa01-27d0-6290-cb16-07d159d6fbb2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.01.2020 06:39, Sameer Pujar пишет:
>>> +static int tegra_ahub_put_value_enum(struct snd_kcontrol *kctl,
>>> +                                  struct snd_ctl_elem_value *uctl)
>>> +{
>>> +     struct snd_soc_component *cmpnt =
>>> snd_soc_dapm_kcontrol_component(kctl);
>>> +     struct tegra_ahub *ahub = snd_soc_component_get_drvdata(cmpnt);
>>> +     struct snd_soc_dapm_context *dapm =
>>> snd_soc_dapm_kcontrol_dapm(kctl);
>>> +     struct soc_enum *e = (struct soc_enum *)kctl->private_value;
>>> +     struct snd_soc_dapm_update update[TEGRA_XBAR_UPDATE_MAX_REG] =
>>> { };
>> Shouldn't this be {0} to make array zero'ed?
> 
> Isn't it the same with empty braces?

Looks like is should be the same because turns out GCC has an extension
for that.

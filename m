Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D14C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D662072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0aanofb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgG3JE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgG3JE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:04:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6CC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:04:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so24127480wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=dLkPvQCKJgLmtxhAhpgyq0oaVyl4KxaYKmt7VGxtZKM=;
        b=0aanofb1Pmi8Nb2xkH5hxKqD1W6jNUmzzGZWcOtUg5PG2nTWPO7GJu35uTo19IUOkB
         eNtBnJNr+YjS0Gx3HH16j25Xp0LH1Z1V5hMf0CBcpCh++w6Dgm4TFgHb1fPiMC2/RiQq
         Q2hK/VI6CZtzWOvjY/S9m3TXJkNKwDKCT0udZlAbN/jn/enZfPlJt4313AVsHCZvgMo8
         eybQZDlCsTzR589AMcbm1lOg57wPv3Fjj2iCWoQoL0meT7WwJoSDT20SpicBaEr3uUHq
         tNjqFVx1moKHIET4kxzC+bzMXtmILtHGvpLU5emNES0xqRBqpat1bAmOxjYZ3w8C1SFU
         LUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=dLkPvQCKJgLmtxhAhpgyq0oaVyl4KxaYKmt7VGxtZKM=;
        b=VaRNHpjai43eguokttC/uYF1Tm5yvnjlCqpUCsLvKOS+GpKT716KhR7WlIHECdI0bo
         FsuEKX/iDdz2FVRmT5vwe887ijx80K1C7h3z/gcrSvl4MWAm11iCJsra0VEwntxY/afu
         cwpuCwZQV2qiH6iWhTdU/FAmtGA4y+QoWe1pDorhQOx/sCfRkXm5BQKlWjGdutLoRsoT
         3ZOHXwoSYoZ2Pd7o5CgvWtZpikTSHJscGf/VGb6XSsQB94Fuf7AKF7D/hLRbCiy/NiOt
         llrcvHe/HyL+KuqdS1XKrzKhhRQAl3aQ+PBK2L79l1w7eGTeVkAoZdjZIc7ZfnQX29n9
         7b5w==
X-Gm-Message-State: AOAM530ZErt66OeoGdRkhjq6KLQ6JkXkAyKn/2avOFEhYLOuInRYTbEW
        KWgNzero0OOW5F6tCjSeQherVw==
X-Google-Smtp-Source: ABdhPJxmATJSo4KpPLqzaNfFVe6yY8EX64Ugci/foH9vN4kteOvN9e7bLXtuTCYoxKZ4BDhP9b8Njw==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr32602052wrq.407.1596099894612;
        Thu, 30 Jul 2020 02:04:54 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n5sm8555408wrx.22.2020.07.30.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:04:53 -0700 (PDT)
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com> <20200729154639.1983854-1-jbrunet@baylibre.com> <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>, zhangn1985@outlook.com,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
In-reply-to: <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
Date:   Thu, 30 Jul 2020 11:04:53 +0200
Message-ID: <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 29 Jul 2020 at 17:56, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> On 7/29/20 10:46 AM, Jerome Brunet wrote:
>> commit b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
>> changed dpcm_playback and dpcm_capture semantic by throwing an error if
>> these flags are not aligned with DAIs capabilities on the link.
>>
>> The former semantic did not force the flags and DAI caps to be aligned.
>> The flag previously allowed card drivers to disable a stream direction on
>> a link (whether or not such feature is deemed useful).
>>
>> With change ('ASoC: core: use less strict tests for dailink capabilities')
>> an error is thrown if the flags and and the DAI caps are not aligned. Those
>> parameters were not meant to aligned initially. No technical reason was
>> given about why cards should now be considered "broken" in such condition
>> is not met, or why it should be considered to be an improvement to enforce
>> that.
>>
>> Forcing the flags to be aligned with DAI caps just make the information
>> the flag carry redundant with DAI caps, breaking a few cards along the way.
>>
>> This change drops the added error conditions and restore the initial flag
>> semantics.
>
> or rather lack thereof.

Again, why ? All there is so far is your personal preference. no facts.

 * What we had gave capabilities to the link, independent of the DAI
   components. ASoC just computes the intersection of all that to
   determine which direction needs to be enabled. Seems rather simple
   and straight forward.
 * It worked for every user of DPCM so a far.

Your changes:
 * Causes regression
 * Makes information redundant. The code used to build the flag in
   snd_soc_dai_link_set_capabilities() and check it soc_new_pcm() is
   more or less the same. It just adds complexity and waste cycles.

I don't see the upside to it.
 
>
> I am ok to move dev_err to dev_warn and remove the return -EINVAL, but I
> maintain that we have to reach a point where configurations make sense
> before we can clean them up. If we implicitly push issues under the rug by
> not even being aware of them we'll never make progress.

But why should we bother the user with that ? How is throwing this
error/warning an improvement ? What does not make sense in the
configuration ? What are we pushing under the rug exactly ?

I'm willing to go your way, even help you out, but you need to:
 * explain concretely why changing the semantics improve the overall
   situation, concretely ?
 * update all the users of DPCM. Causing regression is not OK.

Carrying redundant information makes things complex and error prone.
If you really want to update this, here is another proposition:
 * Removing snd_soc_dai_link_set_capabilities()
 * Removing both flags completely
 * Let ASoC figure out what is needed based on the components present.

>
>>
>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>
>>   Hi Mark,
>>
>>   Because b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
>>   introduced more than one problem, the change
>>   "ASoC: core: use less strict tests for dailink capabilities" [0] is still
>>   necessary but the change of semantic remains a problem with it.
>>
>>   This patch applies on top of it.
>>
>>   sound/soc/soc-pcm.c | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 00ac1cbf6f88..2e205b738eae 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -2749,13 +2749,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>>   					break;
>>   				}
>>   			}
>> -
>> -			if (!playback) {
>> -				dev_err(rtd->card->dev,
>> -					"No CPU DAIs support playback for stream %s\n",
>> -					rtd->dai_link->stream_name);
>> -				return -EINVAL;
>> -			}
>>   		}
>>   		if (rtd->dai_link->dpcm_capture) {
>>   			stream = SNDRV_PCM_STREAM_CAPTURE;
>> @@ -2766,13 +2759,6 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>>   					break;
>>   				}
>>   			}
>> -
>> -			if (!capture) {
>> -				dev_err(rtd->card->dev,
>> -					"No CPU DAIs support capture for stream %s\n",
>> -					rtd->dai_link->stream_name);
>> -				return -EINVAL;
>> -			}
>>   		}
>>   	} else {
>>   		/* Adapt stream for codec2codec links */
>>


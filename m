Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C93C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555C424672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IhXA9nbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1Q5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:57:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1Q5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:57:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so1774891wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=A+A25OPbN7c0Hb+kDxkLLF4o6kk9ftbHcHDjaa9bDHg=;
        b=IhXA9nbgy+q/POpe9udr4TB+ykkDxlX+HTpnb3PggnZ+4YLOovZZoyTtRYlSTpitqC
         /C5iuvnFnvdUUDhTsQYAXzs92WlPtEAJzPXRb+xNWq5QzJIdUkQJBHbUXi8m9RJV3xSj
         y2A3xkboJgJCjSN2ztwh8iB46KpzfEuToyRom2WnTCA3REa1S3R7pUdPB7d8hU20crnb
         hI4UiDmacgpsYcfEGME/3ZoS/Lv+dqZdk5hngbZ34A4rmo0OnXi0pasxyj/KAhYenPOe
         sqj+AsXgDMGWvbsac53SEtIgKhzYMUNxKBgeIrihYFMqVH73AOPiBkrmCIcISy8odjud
         BxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=A+A25OPbN7c0Hb+kDxkLLF4o6kk9ftbHcHDjaa9bDHg=;
        b=K291uddMUKzEd55HoDAgsYKcR32wDSSjoczJ4GG1uBWNf23xoiDyzi1mf/Kno4alZ1
         X7SHzbiuitTCyperrs8C0aFfO2MIGBT3c7MAIGKmS4XFhg2KItTfstyHTum7UWnY7Oio
         AcuTkNR0JgnQNXDZatv99IHiiY9+psIIwzQaZ7lFaM5YcspZVJGc036UoDDJNg8JaI4g
         Ok1lxuMq59vZYIH123BHEq9vrKhJPy8PP0CAljQZOAPgFR0407YR3YV1tL69H+FxPMip
         m3TpBaGYd7BGtnJ+csserzU2LOWHEAfn/REn+BtAT5vIf0RTMl3YYlsfvgt/c0jz3qrm
         slUw==
X-Gm-Message-State: APjAAAWJN+r0N5oKkLpFrqIwtOgTAcNJ0wEpuLMFHqB631Yoe8St4nw/
        Zf2vn9i1UvUuCQLFrZvTu+GY9A==
X-Google-Smtp-Source: APXvYqy1Ur/W3S+TgCWd2fsapozAnq2RpmkzdXDsfH9HZXa0i2WSU1Rbd1rhaCVIj7olyI1mBNqiaQ==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr5990087wmf.56.1582909033626;
        Fri, 28 Feb 2020 08:57:13 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n2sm13817320wro.96.2020.02.28.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:57:12 -0800 (PST)
References: <20200224145821.262873-1-jbrunet@baylibre.com> <20200224145821.262873-3-jbrunet@baylibre.com> <20200228155017.GA24730@bogus>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/9] ASoC: meson: convert axg tdm interface to schema
In-reply-to: <20200228155017.GA24730@bogus>
Date:   Fri, 28 Feb 2020 17:57:12 +0100
Message-ID: <1jpndyejkn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 28 Feb 2020 at 16:50, Rob Herring <robh@kernel.org> wrote:

> On Mon, Feb 24, 2020 at 03:58:14PM +0100, Jerome Brunet wrote:
>> Convert the DT binding documentation for the Amlogic tdm interface to
>> schema.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../bindings/sound/amlogic,axg-tdm-iface.txt  | 22 -------
>>  .../bindings/sound/amlogic,axg-tdm-iface.yaml | 57 +++++++++++++++++++
>>  2 files changed, 57 insertions(+), 22 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
>>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
>> deleted file mode 100644
>> index cabfb26a5f22..000000000000
>> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
>> +++ /dev/null
>> @@ -1,22 +0,0 @@
>> -* Amlogic Audio TDM Interfaces
>> -
>> -Required properties:
>> -- compatible: 'amlogic,axg-tdm-iface'
>> -- clocks: list of clock phandle, one for each entry clock-names.
>> -- clock-names: should contain the following:
>> -  * "sclk" : bit clock.
>> -  * "lrclk": sample clock
>> -  * "mclk" : master clock
>> -	     -> optional if the interface is in clock slave mode.
>> -- #sound-dai-cells: must be 0.
>> -
>> -Example of TDM_A on the A113 SoC:
>> -
>> -tdmif_a: audio-controller@0 {
>> -	compatible = "amlogic,axg-tdm-iface";
>> -	#sound-dai-cells = <0>;
>> -	clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
>> -		 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> -		 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
>> -	clock-names = "mclk", "sclk", "lrclk";
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
>> new file mode 100644
>> index 000000000000..5f04f9cf30a0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Audio TDM Interfaces
>> +
>> +maintainers:
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^audio-controller-.*"
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  compatible:
>> +    items:
>> +      - const: 'amlogic,axg-tdm-iface'
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 3
>> +    items:
>> +      - description: Bit clock
>> +      - description: Sample clock
>> +      - description: Master clock #optional
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 3
>> +    items:
>> +      - const: sclk
>> +      - const: lrclk
>> +      - const: mclk
>> +
>> +required:
>> +  - "#sound-dai-cells"
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>
> Add an:
>
> additionalProperties: false

I did not put that on purpose.
Most of the amlogic devices use an generic ASoC property called
"sound-name-prefix"

You may see examples of that in
arch/arm64/boot/dts/amlogic/meson-axg.dtsi.

That property is not expressed in json schema yet, and I don't
really know what is the best way to add that.

Adding 'additionalProperties: false' right now would generate a fair
amount of warning with 'make dtbs_check'

>
> With that,
>
> Reviewed-by: Rob Herring <robh@kernel.org>


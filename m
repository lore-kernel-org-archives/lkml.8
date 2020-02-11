Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E546C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C542173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9JXf+ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgBKTCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:02:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37873 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgBKTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:02:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so8807504qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8ElLutl/m0ZH3q/Jagn5Sm+o4lBHaVCMWC2w+7i5dQ=;
        b=J9JXf+efOVR0SzD70t/aui7ZMlj9gDR5dOzMNHqIi3LnZA939xxuLrhEUjLovPPR6r
         saDD3EshQmGnPX294Pi+A4dLvQrAYlLtt2KovymDgkzXqEYBrke6MqaUadLRIzzT0OQe
         KJ5ow30BgnINxPHCoZbay5J1cCeJjgpQp44/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8ElLutl/m0ZH3q/Jagn5Sm+o4lBHaVCMWC2w+7i5dQ=;
        b=uLCtQdkzrbeEdLu9V/G+PKaSpxVYlkPFVewguXckAXHgb4m9dN2lfJ6uo0R30WH/Id
         zAvJmyAkLm8NzmPDilAipbcfWqeqzCtyiATu9Ua/1WFSF4efczYO6SZSNkn7yzUJ+VvG
         tlUH8dGs1VU5giZcHBS/67cZpMnIMdw/q7dLaFEyY9S0YPdO4/F8mQvJmdWW6AWlc80Y
         6/29YlPc1Ciera2NfnubuzsK6k6lVUMhQfjNB+L+PX6KMI/+B/CSQiYVZrN03sOZE1oe
         2JohgJZavNhuErjXNQD2jvXzFGXc7vUj4hp2MS55ylpO5WY+vG3wD3jz6faUuxYUnu5D
         JjTg==
X-Gm-Message-State: APjAAAUBn3NtXq+oSdBGTNylUL9Z8BY7EH8YoPFp72YZBrP/kp77PTQ6
        ZP5WhoZkMDmvCDQFw/ZkKPbD+TKK5kE5iv3gpMdmCg==
X-Google-Smtp-Source: APXvYqzmkg+zFNZFV+4XiRoVMucGNuL9B4PTIUZALU995dSqbzMrvzrX9103Tqq3ReaFYomO3EipG7KbvJpkCDjbUKM=
X-Received: by 2002:ac8:5457:: with SMTP id d23mr3594214qtq.93.1581447717756;
 Tue, 11 Feb 2020 11:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20200207203752.209296-1-pmalani@chromium.org> <20200207203752.209296-2-pmalani@chromium.org>
 <dd9a8fa7-db6b-87a0-889d-b56a626a3078@collabora.com> <CACeCKac-OjvCLZ4FefsGbH9JR_suB3nL5CVLa_N0o9qnSqi3-g@mail.gmail.com>
In-Reply-To: <CACeCKac-OjvCLZ4FefsGbH9JR_suB3nL5CVLa_N0o9qnSqi3-g@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 11 Feb 2020 11:01:46 -0800
Message-ID: <CACeCKaeXQK8KCwyZb2JBkLyCYA=+hRAHzdGr5Ycd1mAioAmNPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add cros-ec Type C port driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        heikki.krogerus@intel.com, Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending (because I didn't send it in PlainText mode, so the MLs
blocked the email). Sorry.


On Tue, Feb 11, 2020 at 11:00 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Enric,
>
> Thanks as always for reviewing the patch. Kindly see my responses inline:
>
> On Tue, Feb 11, 2020 at 2:28 AM Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>>
>> Hi Prashant,
>>
>> On 7/2/20 21:37, Prashant Malani wrote:
>> > Some Chrome OS devices with Embedded Controllers (EC) can read and
>> > modify Type C port state.
>> >
>> > Add an entry in the DT Bindings documentation that lists out the logical
>> > device and describes the relevant port information, to be used by the
>> > corresponding driver.
>> >
>> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>> > ---
>> >
>> > Changes in v2:
>> > - No changes. Patch first introduced in v2 of series.
>> >
>> >  .../bindings/chrome/google,cros-ec-typec.yaml | 77 +++++++++++++++++++
>> >  1 file changed, 77 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
>> >
>> > diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
>> > new file mode 100644
>> > index 00000000000000..46ebcbe76db3c2
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
>> > @@ -0,0 +1,77 @@
>> > +# SPDX-License-Identifier: GPL-2.0
>>
>> I think that Google is fine with the dual licensing here. Would be good if this
>> can be (GPL-2.0-only OR BSD-2-Clause)
>
>
> Thanks for catching this. I will update it in the next version.
>>
>>
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Google Chrome OS EC(Embedded Controller) Type C port driver.
>> > +
>> > +maintainers:
>> > +  - Benson Leung <bleung@chromium.org>
>> > +  - Prashant Malani <pmalani@chromium.org>
>> > +
>> > +description:
>> > +  Chrome OS devices have an Embedded Controller(EC) which has access to
>> > +  Type C port state. This node is intended to allow the host to read and
>> > +  control the Type C ports. The node for this device should be under a
>> > +  cros-ec node like google,cros-ec-spi.
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: google,cros-ec-typec
>> > +
>> > +  port:
>> > +    description: A node that represents a physical Type C port on the
>> > +      device.
>> > +    type: object
>> > +    properties:
>> > +      port-number:
>> > +        description: The number used by the Chrome OS EC to identify
>> > +          this type C port.
>> > +        $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Any range of values allowed? 0 is okay?
>
>
> 0 is acceptable. Looks like Chrome OS EC numbers the ports as 0 to (num_ports - 1).
> Actually, looking at it more closely, the port info EC command struct uses uint8_t (https://elixir.bootlin.com/linux/latest/source/include/linux/platform_data/cros_ec_commands.h#L4879)
> Also, num_ports cannot be larger than: https://elixir.bootlin.com/linux/latest/ident/EC_USB_PD_MAX_PORTS
>
> So perhaps this should be updated to say it can be any value from 0 - EC_USB_PD_MAX_PORTS ? (Not sure if I can reference #defines from header files in the DT bindings file....)
>>
>>
>> > +      power-role:
>>
>> Sorry if this question is silly, aren't this and below properties the same as
>> provided by usb-connector?  Can't this be usb-c-connector?
>>
>> Documentation/devicetree/bindings/connector/usb-connector.txt
>
>
> That's correct, it is the same. I think there is a slight difference between the properties of usb-connector (what properties are defined as optional and required) so I don't know if we can re-use usb-connector.
> TBH I wasn't sure about this myself. I am also not sure whether there will be an issue with usb-c-connector being "claimed" by another driver. I think Heikki could perhaps guide us here.
>>
>>
>> > +        description: Determines the power role that the Type C port will
>> > +          adopt.
>> > +        oneOf:
>> > +          - items:
>> > +            - const: sink
>> > +            - const: source
>> > +            - const: dual
>> > +      data-role:
>> > +        description: Determines the data role that the Type C port will
>> > +          adopt.
>> > +        oneOf:
>> > +          - items:
>> > +            - const: host
>> > +            - const: device
>> > +            - const: dual
>> > +      try-power-role:
>> > +        description: Determines the preferred power role of the Type C port.
>> > +        oneOf:
>> > +          - items:
>> > +            - const: sink
>> > +            - const: source
>> > +            - const: dual
>> > +
>> > +    required:
>> > +      - port-number
>> > +      - power-role
>> > +      - data-role
>> > +      - try-power-role
>> > +
>> > +required:
>> > +  - compatible
>> > +  - port
>> > +
>> > +examples:
>> > +  - |+
>>
>> Rob can confirm, but I think is a good practice add the parent node, so add the
>> cros-ec-spi node here?
>
> Done. Will add it in the next version.
>>
>>
>> > +    typec {
>> > +      compatible = "google,cros-ec-typec";
>> > +
>> > +      port@0 {
>>
>> You can run:
>>
>>   make dt_binding_check DT_SCHEMA_FILES=<...>/chrome/google,cros-ec-typec.yaml
>>
>> And you'll get an error:
>>
>>  typec: 'port' is a required property
>
> Noted. I will run this check before pushing next time and fix the error.
>>
>>
>> > +        port-number = <0>;
>> > +        power-role = "dual";
>> > +        data-role = "dual";
>> > +        try-power-role = "source";
>> > +      };
>> > +    };
>> >
>> Thanks,
>>
>>  Enric
>
>
>
> Thanks,
>
> -Prashant

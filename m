Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C201C35246
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0722920CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580318868;
	bh=8s9VvgE+3sDB2RdmAB7O5W3I5IDKHZgTxCsErqXZhSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nAjF9YxnQw4+/E274d6VbCszFurIL4GbnwcmSaHuT9PdTK/5aqkpyAAcbxBPnVv/K
	 5BeQUeWAY6UrNTOsEsAF7q8XGHpGr4wrhUCpVZw0MqwdrBh9Je5Ht7WM+VW0zaRMbj
	 HTdPNQOAUFIldx2q+VX334VF/5NInyjw2/ANe52w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgA2R1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:27:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgA2R1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:27:47 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 465ED20720;
        Wed, 29 Jan 2020 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580318866;
        bh=8s9VvgE+3sDB2RdmAB7O5W3I5IDKHZgTxCsErqXZhSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=10ezr15e4EFnIdqZW3oP3Fqkl8gaag+UDlzQcWWc9Je+DARdUBDAsXI4v2SXhoUp5
         LrVg9YF/freePCz8tzsVEpWkernmrMuqyB5Yfxirq1OeT9lryAb0pxZR78BiJP279D
         fhWJQ4Ltupl/CbKr3yoP0B8hmPlcf8xrxJz+CQqI=
Received: by mail-qv1-f41.google.com with SMTP id dc14so38080qvb.9;
        Wed, 29 Jan 2020 09:27:46 -0800 (PST)
X-Gm-Message-State: APjAAAXIYkT6EiNBtpUiohBBhP9DW96aSjThq3sx2te54WnHYGux6J3F
        qE54qpd4GGq0LrClBNtEXVBeoah+MiCS7Vk4ew==
X-Google-Smtp-Source: APXvYqy7lz7tcOm3C7BBm+WdIc/S57kCUzAVoum0xd24HnI2yv7y4cWPvvqJoSeKtCptCj9v2G0XNP4qKg8IdftRxfU=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr42024qvn.79.1580318865421;
 Wed, 29 Jan 2020 09:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
 <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz> <20200127154800.GA7023@bogus>
 <b1d669567b5f9f00dfb5d6dab89262f68c5523f1.camel@alliedtelesis.co.nz>
In-Reply-To: <b1d669567b5f9f00dfb5d6dab89262f68c5523f1.camel@alliedtelesis.co.nz>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Jan 2020 11:27:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UZvX-Avz7mA=RmhNU3hjKd2se1KODfGt9dfdbn_ACKQ@mail.gmail.com>
Message-ID: <CAL_Jsq+UZvX-Avz7mA=RmhNU3hjKd2se1KODfGt9dfdbn_ACKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
To:     Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:30 PM Logan Shaw
<Logan.Shaw@alliedtelesis.co.nz> wrote:
>
> On Mon, 2020-01-27 at 09:48 -0600, Rob Herring wrote:
> > On Mon, Jan 27, 2020 at 11:10:14AM +1300, Logan Shaw wrote:
> > > Added a new file documenting the adt7475 devicetree and added the
> > > four
> > > new properties to it.
> > >
> > > Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> > > ---

> > > +  bypass-attenuator-in0:
> >
> > Needs a vendor prefix and a type ref.
>
> Adi (Analog Devices) sold the ADT product line (amongst other things)
> to On Semiconductor. As changing the vendor of these chips (in code)
> would break backwards compatibility should we keep the vendor as adi?

Yes. It should match what's used in the compatible string(s).

> To confirm, would this make the property "adi,adt7476,bypass-
> attenuator-in0"?
>
> So used in conjunction with patternProperties you would end up with
> something like:
>
> "adi,(adt7473|adt7475|adt7476|adt7490),bypass-attenuator-in[0134]"

No for the part #'s. Just add 'adi,'. Maybe you thought for type ref
that's what I meant? A type ref is:

$ref: /schemas/types.yaml#/definitions/uint32

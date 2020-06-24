Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EFBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7202088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMBeoFBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbgFXGpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389352AbgFXGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:45:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D66C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:45:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so1231090wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=92ct+kIyuYCkffCnaII7e190oKIVCgMIRLBRHDA+hrQ=;
        b=vMBeoFBR6gWv1XCSeTiSfq4tCcSz6ogFdWuTufhhEEp+YjMHBGUPqKmSHaviBuZMzi
         jJOmcl8gsMyNsctNAEYmqZD8ara+sb6s9sKlGL+AS3XZlxZGcbKFDg+TxZWu35DDTghi
         p45RtWBLtPn5Fm2YVLfxcwi8+uRptoq4dghIgqr2Ze3PDzozh3pE1pNbyfC6dfeDTrIq
         l1Z0odWvxsFi9ZULzqIhf30Gqb5mwhrpmXjOZDPwIFTGGsBGl5osmP4XDaCl3Z0LirID
         0TwpDNaxsfwOyKZixZoSN9iCtFiOCJ8q7utyir8piieszXTmAqHtqwjjgVW1u3r1Saiw
         hLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=92ct+kIyuYCkffCnaII7e190oKIVCgMIRLBRHDA+hrQ=;
        b=HF9ytNSGUgPsEl6YyqcDyCqxlOg2f4R5ZqHkUTC0IWYGyrKCJ5qn03uYuWBTKzMmRk
         Yqwq63wpi/PK67OW+UDKqqaNGBPrvAgn4jPHOBcgnblfCpA0h1Dw0D9x2lKtt0h6YdHF
         DeSo86MvIIdDr/gm2ZpVOlXqxIc78mNWeLYT5DKK1PMeYw+ajxriptA3FNhJWpHvyCfk
         XQENehciLtxdSbdA79u0k56ACDCQkyarFAPuVSfbnscRSBFmmAnLj+rYlNVIiiGceunv
         z/ftYtlqf9bTPWhNZmLwRxFA8DtBY4A4Za6j22UlwquJ300+QaIYdD9uhLTapPaw3XJ2
         Kjzg==
X-Gm-Message-State: AOAM533HLvjbPjqdkqgfX2GGBXZBIn9RPd++yXD82JYdLhEcxD6bb7D7
        1/5ORqD6VGXNmJvyDUgHJ1Oi/Q==
X-Google-Smtp-Source: ABdhPJyVDUfjm/E/allflF2ZvSZxow7JcquGxPsnUrNFqdBmD70tuJE9qiLNwz0mWV2sr/rUv8+dfg==
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr7401130wmb.169.1592981141078;
        Tue, 23 Jun 2020 23:45:41 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u23sm11771941wru.94.2020.06.23.23.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:45:40 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:45:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200624064538.GD954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <2a25af37-a9b8-e4f3-6092-06c1c907dc9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a25af37-a9b8-e4f3-6092-06c1c907dc9f@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020, Frank Rowand wrote:

> On 2020-06-11 14:10, Lee Jones wrote:
> > Currently, when a child platform device (sometimes referred to as a
> > sub-device) is registered via the Multi-Functional Device (MFD) API,
> > the framework attempts to match the newly registered platform device
> > with its associated Device Tree (OF) node.  Until now, the device has
> > been allocated the first node found with an identical OF compatible
> > string.  Unfortunately, if there are, say for example '3' devices
> > which are to be handled by the same driver and therefore have the same
> > compatible string, each of them will be allocated a pointer to the
> > *first* node.
> > 
> > An example Device Tree entry might look like this:
> > 
> >   mfd_of_test {
> >           compatible = "mfd,of-test-parent";
> >           #address-cells = <0x02>;
> >           #size-cells = <0x02>;
> > 
> >           child@aaaaaaaaaaaaaaaa {
> >                   compatible = "mfd,of-test-child";
> >                   reg = <0xaaaaaaaa 0xaaaaaaaa 0 0x11>,
> >                         <0xbbbbbbbb 0xbbbbbbbb 0 0x22>;
> >           };
> > 
> >           child@cccccccc {
> >                   compatible = "mfd,of-test-child";
> >                   reg = <0x00000000 0xcccccccc 0 0x33>;
> >           };
> > 
> >           child@dddddddd00000000 {
> >                   compatible = "mfd,of-test-child";
> >                   reg = <0xdddddddd 0x00000000 0 0x44>;
> >           };
> >   };
> > 
> > When used with example sub-device registration like this:
> > 
> >   static const struct mfd_cell mfd_of_test_cell[] = {
> >         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 0, "mfd,of-test-child"),
> >         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 1, "mfd,of-test-child"),
> >         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 2, "mfd,of-test-child")
> >   };
> > 
> > ... the current implementation will result in all devices being allocated
> > the first OF node found containing a matching compatible string:
> > 
> >   [0.712511] mfd-of-test-child mfd-of-test-child.0: Probing platform device: 0
> >   [0.712710] mfd-of-test-child mfd-of-test-child.0: Using OF node: child@aaaaaaaaaaaaaaaa
> >   [0.713033] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
> >   [0.713381] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@aaaaaaaaaaaaaaaa
> >   [0.713691] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
> >   [0.713889] mfd-of-test-child mfd-of-test-child.2: Using OF node: child@aaaaaaaaaaaaaaaa
> > 
> > After this patch each device will be allocated a unique OF node:
> > 
> >   [0.712511] mfd-of-test-child mfd-of-test-child.0: Probing platform device: 0
> >   [0.712710] mfd-of-test-child mfd-of-test-child.0: Using OF node: child@aaaaaaaaaaaaaaaa
> >   [0.713033] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
> >   [0.713381] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@cccccccc
> >   [0.713691] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
> >   [0.713889] mfd-of-test-child mfd-of-test-child.2: Using OF node: child@dddddddd00000000
> > 
> > Which is fine if all OF nodes are identical.  However if we wish to
> > apply an attribute to particular device, we really need to ensure the
> > correct OF node will be associated with the device containing the
> > correct address.  We accomplish this by matching the device's address
> > expressed in DT with one provided during sub-device registration.
> > Like this:
> > 
> >   static const struct mfd_cell mfd_of_test_cell[] = {
> >         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 1, "mfd,of-test-child", 0xdddddddd00000000),
> >         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 2, "mfd,of-test-child", 0xaaaaaaaaaaaaaaaa),
> >         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 3, "mfd,of-test-child", 0x00000000cccccccc)
> >   };
> > 
> > This will ensure a specific device (designated here using the
> > platform_ids; 1, 2 and 3) is matched with a particular OF node:
> > 
> >   [0.712511] mfd-of-test-child mfd-of-test-child.0: Probing platform device: 0
> >   [0.712710] mfd-of-test-child mfd-of-test-child.0: Using OF node: child@dddddddd00000000
> >   [0.713033] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
> >   [0.713381] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@aaaaaaaaaaaaaaaa
> >   [0.713691] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
> >   [0.713889] mfd-of-test-child mfd-of-test-child.2: Using OF node: child@cccccccc
> > 
> > This implementation is still not infallible, hence the mention of
> > "best effort" in the commit subject.  Since we have not *insisted* on
> > the existence of 'reg' properties (in some scenarios they just do not
> > make sense) and no device currently uses the new 'of_reg' attribute,
> > we have to make an on-the-fly judgement call whether to associate the
> > OF node anyway.  Which we do in cases where parent drivers haven't
> > specified a particular OF node to match to.  So there is a *slight*
> > possibility of the following result (note: the implementation here is
> > convoluted, but it shows you one means by which this process can
> > still break):
> > 
> >   /*
> >    * First entry will match to the first OF node with matching compatible
> >    * Second will fail, since the first took its OF node and is no longer available
> >    * Third will succeed
> >    */
> >   static const struct mfd_cell mfd_of_test_cell[] = {
> >         OF_MFD_CELL("mfd-of-test-child", NULL, NULL, 0, 1, "mfd,of-test-child"),
> > 	OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 2, "mfd,of-test-child", 0xaaaaaaaaaaaaaaaa),
> >         OF_MFD_CELL_REG("mfd-of-test-child", NULL, NULL, 0, 3, "mfd,of-test-child", 0x00000000cccccccc)
> >   };
> > 
> > The result:
> > 
> >   [0.753869] mfd-of-test-parent mfd_of_test: Registering 3 devices
> >   [0.756597] mfd-of-test-child: Failed to locate of_node [id: 2]
> >   [0.759999] mfd-of-test-child mfd-of-test-child.1: Probing platform device: 1
> >   [0.760314] mfd-of-test-child mfd-of-test-child.1: Using OF node: child@aaaaaaaaaaaaaaaa
> >   [0.760908] mfd-of-test-child mfd-of-test-child.2: Probing platform device: 2
> >   [0.761183] mfd-of-test-child mfd-of-test-child.2: No OF node associated with this device
> >   [0.761621] mfd-of-test-child mfd-of-test-child.3: Probing platform device: 3
> >   [0.761899] mfd-of-test-child mfd-of-test-child.3: Using OF node: child@cccccccc
> > 
> > We could code around this with some pre-parsing semantics, but the
> > added complexity required to cover each and every corner-case is not
> > justified.  Merely patching the current failing (via this patch) is
> > already working with some pretty small corner-cases.  Other issues
> > should be patched in the parent drivers which can be achieved simply
> > by implementing OF_MFD_CELL_REG().
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > Changelog:
> > 
> > v1 => v2:
> >   * Simply return -EAGAIN if node is already in use
> >   * Allow for valid of_reg=0 by introducing use_of_reg boolean flag
> >   * Split helpers out into separate patch
> > 
> > drivers/mfd/mfd-core.c   | 99 +++++++++++++++++++++++++++++++++++-----
> >  include/linux/mfd/core.h | 10 ++++
> >  2 files changed, 97 insertions(+), 12 deletions(-)

[...]

> > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > index d01d1299e49dc..a148b907bb7f1 100644
> > --- a/include/linux/mfd/core.h
> > +++ b/include/linux/mfd/core.h
> > @@ -78,6 +78,16 @@ struct mfd_cell {
> >  	 */
> >  	const char		*of_compatible;
> >  
> > +	/*
> > +	 * Address as defined in Device Tree.  Used to compement 'of_compatible'
> > +	 * (above) when matching OF nodes with devices that have identical
> > +	 * compatible strings
> > +	 */
> 
> Instead of the above comment, suggest something like instead (I have not properly
> line wrapped, to make it easier to see the difference):
> 
>    > +	/*
>    > +	 * Address as defined in Device Tree mfd child node "reg" property.  Used in combination with 'of_compatible'
>    > +	 * (above) when matching OF nodes with devices that have identical
>    > +	 * compatible strings
>    > +	 */

I'll split the difference and make it more clear, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

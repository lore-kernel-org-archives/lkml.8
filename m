Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F5AC11D25
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC6208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBe4Mgrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgBUATD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:19:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32956 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgBUATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:19:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so112821plb.0;
        Thu, 20 Feb 2020 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8eAGz/pqZqFUKTP2bb1ydmrb6R3JRzc7hCsXNdSvFE=;
        b=TBe4MgrvRwfcCIFOsb4htsXOSxVcnusqrAp17ZTJA173b0arMS87znuql6TLiLPBBs
         PUI3JNY1QM7e6eVYQK/vYJOS0acsigUqNnhX3AgH6+Wa5BTODyQLPukZVHgBXPmcc0GD
         haF2UjOXFpcKHDe6xCbZi2TfFPwvrkmwMDlOE1hVjuhCfeWM3XuLh32Kk/JwhsCDrHnN
         jdVBKWjt8fel7CLaF4sBq3VwDgaDbrjdkParEcYLojLvI1jfB9+r7Rtytk4PStJ48UnM
         7YO6HNVkBXDnmU4Jf+rosLXooazseivSUcFWJ2+MzelyGvo3JKWGNBWZYyidtEMYaWRY
         SRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8eAGz/pqZqFUKTP2bb1ydmrb6R3JRzc7hCsXNdSvFE=;
        b=EFNXHmp+LJA9rPKZmje7ehRidAJLHraXuxsMbrexziedx4iJG2QOCaRA+HZhPj8fT5
         byTptY2NqVjaPHdUMjZLnH8NCVAC/8D50LQtJzZAut+7rVNCzEYRvpiIPG464nglPNOL
         X+KN18pMi2/pDKLgF+MYjXY3WxUETs+zabdzM2THP0BjKCEnTqhOdATUo2K+pvVOussP
         IsElb4XnBGtwy1L5GrlL8/Zl3kiI8HneJDgOG7p23z0dJ6yyvjlD3cazjyStNzTvgXwb
         qVx8i3YN5aKq19foiaCY+XhG0geDC9snG+4npBzC6KkxGkDd2pK5XDcfkR2wLxfDfUjc
         InmA==
X-Gm-Message-State: APjAAAV/W4wcoVSL2MVJcZ19RaYgGx1RWhyCr+rSMaOopqTEMxgJ6/ys
        wY00DkzvpLkjRa7HjY4KfSc=
X-Google-Smtp-Source: APXvYqxdsEuhmZdInMso9eiW6bEOqmFq+cTvdyjVdA/nX5v1Zwxgg1ArC+STWWuiDuN1sQuyoE/14w==
X-Received: by 2002:a17:902:7449:: with SMTP id e9mr32417669plt.139.1582244341895;
        Thu, 20 Feb 2020 16:19:01 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::6:8f30])
        by smtp.gmail.com with ESMTPSA id d2sm544486pjv.18.2020.02.20.16.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 16:19:01 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:18:54 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH 1/2] usb: gadget: aspeed: allow to customize vhub device
 IDs/strings
Message-ID: <20200221001853.GA7815@taoren-ubuntu-R90MNF91>
References: <20200218235600.6763-1-rentao.bupt@gmail.com>
 <20200218235600.6763-2-rentao.bupt@gmail.com>
 <86ab18e4ed01c6856ff47c859a3dda598dd94978.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ab18e4ed01c6856ff47c859a3dda598dd94978.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Thu, Feb 20, 2020 at 12:38:10PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2020-02-18 at 15:55 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch allows people to customize vendor/product/device IDs and
> > manufacture/product/serial strings in vhub's device descriptor through
> > device tree properties.
> 
> You should probably add a binding file to Documentation/devicetree/bindings/usb/*
> 
> We got away without one bcs there was no funky properties there but
> now that we are adding some, we need to document them.

Sure. Andrew also reminded me about the binding document. Will include
the document in patch v2.

> 
> Also...
> 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 73 +++++++++++++++++++-----
> >  1 file changed, 59 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > index 9c7e57fbd8ef..4e3ef83283a6 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > @@ -43,19 +43,23 @@
> >   *    - We may need to indicate TT support
> >   *    - We may need a device qualifier descriptor
> >   *	as devices can pretend to be usb1 or 2
> > - *    - Make vid/did overridable
> >   *    - make it look like usb1 if usb1 mode forced
> >   */
> >  #define KERNEL_REL	bin2bcd(((LINUX_VERSION_CODE >> 16) & 0x0ff))
> >  #define KERNEL_VER	bin2bcd(((LINUX_VERSION_CODE >> 8) & 0x0ff))
> >  
> >  enum {
> > +	AST_VHUB_STR_INDEX_MAX = 4,
> >  	AST_VHUB_STR_MANUF = 3,
> >  	AST_VHUB_STR_PRODUCT = 2,
> >  	AST_VHUB_STR_SERIAL = 1,
> >  };
> >  
> > -static const struct usb_device_descriptor ast_vhub_dev_desc = {
> > +/*
> > + * Below is the default Device Descriptor of the vhub device. Some fields
> > + * may be updated in "ast_vhub_fixup_dev_desc" function.
> > + */
> > +static struct usb_device_descriptor ast_vhub_dev_desc = {
> >  	.bLength		= USB_DT_DEVICE_SIZE,
> >  	.bDescriptorType	= USB_DT_DEVICE,
> >  	.bcdUSB			= cpu_to_le16(0x0200),
> > @@ -148,10 +152,14 @@ static struct usb_hub_descriptor ast_vhub_hub_desc = {
> >  };
> >  
> >  /*
> > - * These strings converted to UTF-16 must be smaller than
> > - * our EP0 buffer.
> > + * Below tables define the default Language ID and String Descriptors of
> > + * the vhub. Language ID and strings may be overridden if according device
> > + * tree properties are defined. Refer to "ast_vhub_fixup_dev_desc" function
> > + * for details.
> > + * Note: these strings converted to UTF-16 must be smaller than vhub EP0
> > + * buffer size.
> >   */
> > -static const struct usb_string ast_vhub_str_array[] = {
> > +static struct usb_string ast_vhub_str_array[] = {
> >  	{
> >  		.id = AST_VHUB_STR_SERIAL,
> >  		.s = "00000000"
> > @@ -167,7 +175,7 @@ static const struct usb_string ast_vhub_str_array[] = {
> >  	{ }
> >  };
> 
> I dislike this. The array should remain static and contain the
> defaults. The properties shouldn't modify the global array, there could
> be a future chip with multiple vhubs and that would make them stomp on
> each other.
> 
> Instead, duplicate the properties into the per-vhub instance data and
> update the content there.

Okay. I will include a copy of the descriptors in struct ast_vhub and
override per-hub instances if needed.

> 
> You could also skip using usb_gadget_get_string() and expose the low
> level conversion function directly though that's trickier.
> 
> Also have you thought about supporting a list of strings along with an
> array of language IDs ? Vendors might want to provide multiple
> languages...

I thought people (aspeed bmc users) won't care much about multi-language
usb strings in the near future. Maybe I'm wrong, but if this is what we
want for now, I will try to add the support, but will need more guidance
from you (such as device tree structure, dt property value to utf-16
conversion, and etc.).


Cheers,

Tao

> 
> > -static const struct usb_gadget_strings ast_vhub_strings = {
> > +static struct usb_gadget_strings ast_vhub_strings = {
> >  	.language = 0x0409,
> >  	.strings = (struct usb_string *)ast_vhub_str_array
> >  };
> > @@ -320,18 +328,15 @@ static int ast_vhub_rep_string(struct ast_vhub_ep *ep,
> >  			       u8 string_id, u16 lang_id,
> >  			       u16 len)
> >  {
> > -	int rc = usb_gadget_get_string (&ast_vhub_strings, string_id, ep->buf);
> > -
> > -	/*
> > -	 * This should never happen unless we put too big strings in
> > -	 * the array above
> > -	 */
> > -	BUG_ON(rc >= AST_VHUB_EP0_MAX_PACKET);
> > +	int rc;
> > +	u8 buf[256]; /* buffer size required by usb_gadget_get_string */
> >  
> > -	if (rc < 0)
> > +	rc = usb_gadget_get_string(&ast_vhub_strings, string_id, buf);
> > +	if (rc < 0 || rc >= AST_VHUB_EP0_MAX_PACKET)
> >  		return std_req_stall;
> >  
> >  	/* Shoot it from the EP buffer */
> > +	memcpy(ep->buf, buf, rc);
> >  	return ast_vhub_reply(ep, NULL, min_t(u16, rc, len));
> >  }
> >  
> > @@ -837,11 +842,51 @@ void ast_vhub_hub_reset(struct ast_vhub *vhub)
> >  	writel(0, vhub->regs + AST_VHUB_EP1_STS_CHG);
> >  }
> >  
> > +static void ast_vhub_fixup_dev_desc(struct ast_vhub *vhub)
> > +{
> > +	int i;
> > +	u8 id;
> > +	u16 of_id;
> > +	const char *of_str[AST_VHUB_STR_INDEX_MAX] = {NULL};
> > +	struct device_node *np = vhub->pdev->dev.of_node;
> > +
> > +	/*
> > +	 * Update IDs in device descriptor if according properties are
> > +	 * defined in device tree.
> > +	 */
> > +	if (!of_property_read_u16(np, "vendor-id", &of_id))
> > +		ast_vhub_dev_desc.idVendor = cpu_to_le16(of_id);
> > +	if (!of_property_read_u16(np, "product-id", &of_id))
> > +		ast_vhub_dev_desc.idProduct = cpu_to_le16(of_id);
> > +	if (!of_property_read_u16(np, "device-id", &of_id))
> > +		ast_vhub_dev_desc.bcdDevice = cpu_to_le16(of_id);
> > +
> > +	/*
> > +	 * Update string descriptors if according properties are defined
> > +	 * in device tree.
> > +	 */
> > +	if (!of_property_read_u16(np, "language-id", &of_id))
> > +		ast_vhub_strings.language = of_id;
> > +
> > +	of_str[AST_VHUB_STR_MANUF] = of_get_property(np, "manufacturer", NULL);
> > +	of_str[AST_VHUB_STR_PRODUCT] = of_get_property(np, "product", NULL);
> > +	of_str[AST_VHUB_STR_SERIAL] = of_get_property(np, "serial-number",
> > +						      NULL);
> > +
> > +	for (i = 0; ast_vhub_str_array[i].s != NULL; i++) {
> > +		id = ast_vhub_str_array[i].id;
> > +		if (of_str[id])
> > +			ast_vhub_str_array[i].s = of_str[id];
> > +	}
> > +}
> > +
> >  void ast_vhub_init_hub(struct ast_vhub *vhub)
> >  {
> >  	vhub->speed = USB_SPEED_UNKNOWN;
> >  	INIT_WORK(&vhub->wake_work, ast_vhub_wake_work);
> >  
> > +	ast_vhub_fixup_dev_desc(vhub);
> > +
> >  	/*
> >  	 * Fixup number of ports in hub descriptor.
> >  	 */
> 

Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78FFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9219020786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D81tfc3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Eiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:38:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14160 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgH0Eir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:38:47 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200827043841epoutp03992b09f5cd4cbf40eb41a3a9698c86e3~vBh7CO_E41917519175epoutp03a
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:38:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200827043841epoutp03992b09f5cd4cbf40eb41a3a9698c86e3~vBh7CO_E41917519175epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598503121;
        bh=qCWPrfdruCkeKVBXUGB0XNsN790tUmHM0okcm60Ch/w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D81tfc3EDjtQuNhR/7no8BgRy5cdN/aNNNNZ/JhKcy0YVhjR/33VujtDJ2LGR+N2X
         MRgUhZ/k3blit71bH76VzEtt1Aba11uF9A1kHYJorrKw1Qn9SFOQiSddDIUJjQoVnj
         gGfeQu2nf6ky09QTmDLiJ+Po8fByMYC6O4/KOdbQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200827043841epcas1p3dea8a2b4e0dbb7115914cea32df59b19~vBh6gwJc02433824338epcas1p3v;
        Thu, 27 Aug 2020 04:38:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4BcVNY0j7RzMqYkk; Thu, 27 Aug
        2020 04:38:37 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.9B.18978.CC8374F5; Thu, 27 Aug 2020 13:38:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200827043836epcas1p2552f5cc00c76240e21a062b236e2f748~vBh1rca9y2014220142epcas1p2r;
        Thu, 27 Aug 2020 04:38:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200827043836epsmtrp163ed5e986728fcacbb6c7ddfc24656d1~vBh1qZmFC2984029840epsmtrp1v;
        Thu, 27 Aug 2020 04:38:36 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-ff-5f4738ccc080
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.FE.08303.BC8374F5; Thu, 27 Aug 2020 13:38:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200827043835epsmtip168f1b1965183fb28caa40cab0018d19a~vBh1ciZMu2047920479epsmtip1r;
        Thu, 27 Aug 2020 04:38:35 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] extcon: ptn5150: Set the VBUS and POLARITY
 property state
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b44d90d2-e91d-afd4-22c0-f64400ba9e11@samsung.com>
Date:   Thu, 27 Aug 2020 13:51:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200827035633.37348-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmru5ZC/d4g8+rmCyuv42w6Fq9k8Xi
        /PkN7BaXd81hs7jduILN4kvHejaLDcfus1m83D+d1aKp6TibA6fHzll32T0W73nJ5LFpVSeb
        x7yTgR59W1YxenzeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeY
        m2qr5OIToOuWmQN0k5JCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0
        L10vOT/XytDAwMgUqDAhO+P4XNuCR+IV8988ZW1gPC3cxcjBISFgIvHkoU8XIxeHkMAORolP
        q5+wQDifGCUOz++Bcj4zSvx78JWti5ETrOPEgivMEIldjBI/tn0ESwgJvGeUmPq0EMQWFgiX
        mLBiCxvIChGBfIkzTwRBwswC2xklHq2uB7HZBLQk9r+4AdbKL6AocfXHY0YQm1fATuLMnK1g
        NouAqsTvRV1gNaICYRInt7VA1QhKnJwJciknB6dAoMSCb/1MEPPFJW49mQ9ly0tsfzsH7E4J
        gZUcEssOvmGEeMBFYsXiPlYIW1ji1fEt7BC2lMTL/jYou1pi5ckjbBDNHYwSW/ZfgGowlti/
        dDITyGPMApoS63fpQ4QVJXb+nssIsZhP4t3XHlZI8PJKdLQJQZQoS1x+cJcJwpaUWNzeyTaB
        UWkWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwBA5qjcxghOrlukOxolvP+gdYmTiYDzE
        KMHBrCTCK3jROV6INyWxsiq1KD++qDQntfgQoykwgCcyS4km5wNTe15JvKGpkbGxsYWJoZmp
        oaGSOO/DWwrxQgLpiSWp2ampBalFMH1MHJxSDUwVESrcXcZ1nLadxyO9t8Stv3Hjzu1lzz50
        p4T9emLgmtnwjJ/lrrc9m3CYtq+WiMZCroPu5rfD38ht2eR00mnuq1Aeg8UxrS91n/7adLlx
        RYvkneAMCfYYJUG/51Vd5+ZI3lXptZveYH1c13rPQaXI+C//lRYFaf8Xc2H60CVUoaraYNlW
        uT/1z/fvbP1GLIv9ajdJ/f2ry3rV7dHa1yeP7L5xjE30jtZeq28VN3i3R6p+qnGu/rLstVJ4
        NN+nlR9n8q1OzZyvz34qXTNphcd/AxN9NpHP0cXvfvh49j/OVchMs19rvkyGr7R3P//8ubuc
        51/YZCAerNg9Xzb7xS+V83lx4oyyPXcTliz3V2Ipzkg01GIuKk4EAFbwhNM1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO4ZC/d4gwndzBbX30ZYdK3eyWJx
        /vwGdovLu+awWdxuXMFm8aVjPZvFhmP32Sxe7p/OatHUdJzNgdNj56y77B6L97xk8ti0qpPN
        Y97JQI++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKOD7XtuCReMX8N09ZGxhPC3cxcnJICJhI
        nFhwhbmLkYtDSGAHo8SXia/ZIBKSEtMuHgVKcADZwhKHDxdD1LxllHh3cBMjSI2wQLjEhBVb
        wOpFBPIl3s3czQpSxCywnVHi+PlrLBAdr4GmLn3NDlLFJqAlsf/FDbAOfgFFias/HoNN4hWw
        kzgzZyuYzSKgKvF7URdYjahAmMTOJY+ZIGoEJU7OfMICYnMKBEos+NYPFmcWUJf4M+8SM4Qt
        LnHryXyouLzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHGlaWjsY96z6oHeIkYmD8RCjBAezkgiv4EXneCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwrf5gu/uW5/qC6uirTSanpquI7ZpZrjXD
        dLvidE+271s/+ih8a7zgLuV3zLd6b1pGlYiqoP0WuSO+6teb/yxZLn3474Fj3IevKuntVxT9
        8zBYXfbSpcKXfEvmPK3k9z/7LuXZbQVPiVpGnpU8pk3Zc/J1TOM3H6x2+yQUE1i09+IP9UsP
        TL1WOuffuCsQcOJuefkdQckXggHd4j1tQlOFdvyJuLZRyDV0apiF6+4Eb14B4V272RXFuBlv
        PWL2Srr+U2mHzdzAJJH3fnVL7Kds4Nkyy0S38NM78UMK/oebEhOY1/Pm6/57bJ7SuTdimczJ
        g3Zuc54c5dX/7vvu1cpnTz8vf3BKIuz/ok+Bn1XWKLEUZyQaajEXFScCAEfgUsEjAwAA
X-CMS-MailID: 20200827043836epcas1p2552f5cc00c76240e21a062b236e2f748
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200827035651epcas1p33a045925293860a361a3be0cf21a2e2a
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <CGME20200827035651epcas1p33a045925293860a361a3be0cf21a2e2a@epcas1p3.samsung.com>
        <20200827035633.37348-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You better to change the 'state' word to 'capability'.
Actually, this patch doesn't change the value of property.
It set the capability value of property.

"Set the VBUS and POLARITY property capability"

On 8/27/20 12:56 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Set the VBUS and POLARITY property state.

ditto. Need to change the work from 'state' and 'capability'.

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 8b930050a3f1..b5217a61615c 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -279,6 +279,12 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  		return ret;
>  	}
>  
> +	extcon_set_property_capability(info->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);

Need to add blank line.

I understood that you set the property capability
because of get_flipped() function of your patch[1].

But, I think that you need to change the value of EXTCON_PROP_USB_TYPEC_POLARITY
when changing the state of EXTCON_USB_HOST. The polarity property value is always
zero regardless of EXTCON_USB_HOST state as following: The get_flipped()[1] returns
always the same *flipped value.

	EXTCON_USB_HOST is 1, EXTCON_PROP_USB_TYPEC_POLARITY is 0
	EXTCON_USB_HOST is 0, EXTCON_PROP_USB_TYPEC_POLARITY is 0

If EXTCON_PROP_USB_TYPEC_POLARITY value is not related to any behavior,
you don't need to get the property value from extcon consumer driver
like drivers/phy/phy-lgm-usb.c.

Actually, I don't understand why you don't handle the value
of EXTCON_PROP_USB_TYPEC_POLARITY. 

Or, are there any case of what drivers/phy/phy-lgm-usb.c
uses the different extcon device with EXTCON_PROP_USB_TYPEC_POLARITY property
in the future?

So, do you set the EXTCON_PROP_USB_TYPEC_POLARITY capability 
for the extensibility in order to use other extcon device on later?


[1] https://www.spinics.net/lists/devicetree/msg371828.html
+static int get_flipped(struct tca_apb *ta, bool *flipped)
+{
+	union extcon_property_value property;
+	int ret;
+
+	ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
+				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
+	if (ret) {
+		dev_err(ta->phy.dev, "no polarity property from extcon\n");
+		return ret;
+	}
+
+	*flipped = property.intval;
+
+	return ret;
+}


>  	/* Initialize PTN5150 device and print vendor id and version id */
>  	ret = ptn5150_init_dev_type(info);
>  	if (ret)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

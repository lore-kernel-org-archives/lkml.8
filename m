Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD8A206D4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="ZLjbW7T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHDNud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:50:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A801C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:50:25 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so13990179qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zZR1aw/C1j3Z94lfHg4klbxDZsffYvl6FLK1cn2mIw=;
        b=ZLjbW7T6CvbkPrhE+3/mxt6kWDKhsaThM+mPYZmy/c5Dp8FeNvWjggXtLKRh1s4la/
         87VtW5hdAMC6z2mL9tunJa+WBajB+148Sz8mHAQeET+nA6/SnaZT13YFBSFC/ue1gEV6
         kCvY+ciyMb3P0Cea9Zhg7ZlIPrS+DGYcXsOgjwxUI9seKoCzDKKkKaRsN3nazwumsGwW
         hPZnijcEyIjJgHRjqOTb4/UA47b7owX0/s860ZgcnYDT+WYFGiHfeLI2ZSqsvpXwyMTk
         SHn98m1MdlBj23txFl92LZuuElRN8S1+aCWtdZPeXfHpBKKtSN2fXxP1CbVCl8Mh5GTn
         kycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zZR1aw/C1j3Z94lfHg4klbxDZsffYvl6FLK1cn2mIw=;
        b=JWhRZI0egO3O04K6wdXSvvEyWkBrG7loccW4zo0W35SNTggMh7qzYdXVnhWrNd88Fv
         A6J/6aY771CDC75jyk22n+fqX2yaLZWOv2Qt7RqgoaFr1qykbQPpOCzK2ThFKt7phr9o
         E+Gim8BrBBfCHsW4Qnc33pLzprxaL5nFAkjTq5xbiPtZVWiOeDLmFcyTzsTuieT/uVtO
         EIDjdjf6+lUTjN6HPCbNalGmTmrYnDc0Z1TWCkYcFBgudW4dZc0/loxAWIE26LMPsjhN
         7cnvJtScq4R/+FAbDIhl3EDc2V45VVOKDKx39j/lZb/85jMH8pnhtOFBwLI9H3Xr1RZ1
         /slA==
X-Gm-Message-State: AOAM532w2ZjEXTwSfHiGGCH5f5eO5lhJoLXn+r2RpxhZ+uoU+2WxC+ai
        X/q/2IAAFq1BF9Cre4sAzpnpqLgme5U/+b/qVhPk6A==
X-Google-Smtp-Source: ABdhPJySFOcllxSVhAbftP85hEf+hmmuW8S+AviGM34bDACSdq9DJNDEkvte+Be+SjqrL9wh0GqBlydyqV2mZXfEq1A=
X-Received: by 2002:ad4:4d03:: with SMTP id l3mr18479458qvl.155.1596549024121;
 Tue, 04 Aug 2020 06:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com> <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com> <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com>
In-Reply-To: <20200804064154.GE696690@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 4 Aug 2020 10:50:13 -0300
Message-ID: <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 3:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 03, 2020 at 07:04:56PM -0300, Daniel Gutson wrote:
> > > > > Think of this as an input device.  You don't put the random input
> > > > > attributes all in one place, you create a new device that represents the
> > > > > input interface and register that.
> >
> > I'm having trouble with this. What's the dev_t for the child devices?
> > I'm doing
> >     child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > NULL, "child");
> > pdev is the pci_device (intel-spi-pci)
> > dmesg shows
> >
> >     sysfs: cannot create duplicate filename '/class/my-class'
> >     (call trace)
> >     kobject_add_internal failed for my-class with -EEXIST, don't try
> > to register things with the same name in the same directory.
>
> Without seeing all of your code, I can't tell you what you are doing
> wrong, but the kernel should be giving you a huge hint here...
>
> Don't create duplicate names in the same subdirectory.

I'm not doing that. One of my questions is if MKDEV(0, 0) is valid for
create_device, which I inferred so from the documentation.
Here is the listing

static ssize_t howareyou_show(struct class *class, struct class_attribute *attr,
    char *buf)
{
return sprintf(buf, "%s\n", "How are you?");
}
static CLASS_ATTR_RO(howareyou);

static struct class my_class = {
        .name =         "my-class",
        .owner =        THIS_MODULE,
};

struct device* child_device;


static int mypci_probe(struct pci_dev *pdev,
       const struct pci_device_id *id)
{
int ret;

ret = pcim_enable_device(pdev);
if (ret)
return ret;

ret = class_register(&my_class);
if (ret < 0)
return ret;


pr_info("DFG: Recognized. DID: %lx\n", (unsigned long int)id->driver_data);
pr_info("DFG: device DID: %lx\n", (unsigned long int)pdev->device);

ret = class_create_file(&my_class, &class_attr_howareyou);
if (ret != 0)
{
    pr_err("DFG class create file error: %d\n", ret);
        class_unregister(&my_class);
        return ret;
}

    child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
NULL, "child");
if (child_device == NULL)
{
    pr_err("DFG error child device NULL");
}

return ret;
}

static void mypci_remove(struct pci_dev *pdev)
{
/* I tried enabling and disabling this code
if (child_device != NULL)
{
put_device(child_device);
device_unregister(child_device);
}
*/

    class_remove_file(&my_class, &class_attr_howareyou);
    class_unregister(&my_class);
}

static const struct pci_device_id my_dids[] = {
{ PCI_VDEVICE(INTEL, 0xa30e), (unsigned long)0xa30e },
{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)0xa324 },
{ },
};
MODULE_DEVICE_TABLE(pci, my_dids);

static struct pci_driver my_pci_driver = {
.name = "dfg-pci",
.id_table = my_dids,
.probe = mypci_probe,
.remove = mypci_remove,
};

module_pci_driver(my_pci_driver);

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("Daniel Gutson <daniel.gutson@eclypsium.com>");


>
> thanks,
>
> greg k-h



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport

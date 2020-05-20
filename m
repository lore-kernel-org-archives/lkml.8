Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F304F20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgETVwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:52:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52947 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgETVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:52:06 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MO9r5-1jQLZl1ulV-00OV7U for <linux-kernel@vger.kernel.org>; Wed, 20 May
 2020 23:52:04 +0200
Received: by mail-qk1-f172.google.com with SMTP id i14so5224787qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:52:04 -0700 (PDT)
X-Gm-Message-State: AOAM530rxGpOOfOFC7gen3OC2//H7nVSPoec/En2Y1MKUqtbptJUWx5R
        1rLFDWLEQGDumRt+xrvs+zaEsKInC7d2xSWu/aI=
X-Google-Smtp-Source: ABdhPJxRbi0MiQo5LHl7IsWyHK1uuyEIhLaUVN+AuiR50+YI5y03MH2otO1L7nuScC6ChfjLJivuQ626xbz3vZftMA0=
X-Received: by 2002:a37:434b:: with SMTP id q72mr7329549qka.352.1590011523351;
 Wed, 20 May 2020 14:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <20200518091222.27467-8-sudeep.holla@arm.com>
 <CAK8P3a20R+H6m5GZj2_0w3s-xF+J_qSVrQH8EjyQXe6+9WTYxw@mail.gmail.com> <20200518115546.GB16262@bogus>
In-Reply-To: <20200518115546.GB16262@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 23:51:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3bOEL5wYFc1Fjg1vAT51NumzO0iUSroHQLSUt8WpZL7g@mail.gmail.com>
Message-ID: <CAK8P3a3bOEL5wYFc1Fjg1vAT51NumzO0iUSroHQLSUt8WpZL7g@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] firmware: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CyleiRwEDypNb05YSJ6bg7Nn/wTfL1FwmUjlWLFo0eOLEbdNt2i
 R4wnu+8vRfz1lPsTWoxAI9uYOu//apgDyUXyHyIbw/rP4hwLj0NGZH16tvzh5UlS48+8nIu
 sOI3jsQAx+ZIGofTpFopoJoBHukt1juzUQaFzTJAp4MgnrSRV4YJ0RsnNkGeVoo+5ApTXM1
 Lt4by6mQZXEcm606c3G2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2/O97iSHWnE=:nqog+HJPlih32H3radIoes
 B8xiIaC8ZrtbQ+VzQBlkiI3xaR6RG4Ly8N014iXy62JShe0VabL3uu54h78DjkMZntoxMGLrZ
 b+1m46AXlITXtuJU1aKkxHD0Od+aWqNXfAH3qjFbK+KwVQ3IXGQj0IXkOAjhNw2+sjCqRsU7v
 UctWAmTrqz54j8/rM89+6gx2CxJf2eUtxTw2VPMtwbvoPvluJg8+G7bGdT9kwYogyHb8BW0Kq
 4PceH6St7WvA2Kj2EWyvjksC8hLVNaiUs65xuc0QPnHp/HxU7yggg1uvggFjzAqEM+5aDjGjR
 /8MzcpqV7AF2hMm/ra4yzcgA4N/CXxnlTKACM1UW5jihQS1GeilxT0NwKiFWoYKfj/656Z1je
 cteB64RzQ2lHxQdGphk3VkQNasgPX7iK5rle6s91UOnhr8AsxXva8Y6+vPqAeS0DitSyJ760B
 XqyK1ZCq5Rj0je0HW1Jm7BoB9YXxbemeU5VFwqfGbYgCv5ICf4S3RdW90wOQTayHhVJIdIpCy
 pazRo4Z6lPWQvdTzLlUFQnZ3ncuHeQsW5XYiuFEkV0R6BmpdsOtsWadHsKp0tm8TjzMJrme8b
 Ai6QlXVMsfTFKvofTLBt+hsX923+bgKJOnyhCqrqTs4p5JEWU35ytttq+CYmwQvOEE8MG5+En
 ShA1P+2UCHKRvCjAamkOSmhCjTdVWasJ7ykGr7isRQUGI9vdCeI48N+3DgEf5v1CJ9hEkeu8a
 ksNSmwP9fH2Z8A7HPUQpP4f6aB42bFjlWoRIEaaCfgZb5NdUvTJB/Iq5rk6+LDdXT9b6NPz+C
 53vFloliXcojPH0/UA3VpktbwvPpHYHB8osDzxCPxABjV3dU+o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 1:55 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 18, 2020 at 11:30:21AM +0200, Arnd Bergmann wrote:
> > On Mon, May 18, 2020 at 11:12 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > > +static ssize_t
> > > +jep106_cont_bank_code_show(struct device *dev, struct device_attribute *attr,
> > > +                          char *buf)
> > > +{
> > > +       return sprintf(buf, "0x%02x\n", JEP106_BANK_CONT_CODE(soc_id_version));
> > > +}
> > > +
> > > +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> > > +
> > > +static ssize_t
> > > +jep106_identification_code_show(struct device *dev,
> > > +                               struct device_attribute *attr, char *buf)
> > > +{
> > > +       return sprintf(buf, "0x%02x\n", JEP106_ID_CODE(soc_id_version));
> > > +}
> >
> > I think we should try hard to avoid nonstandard attributes for the soc device.
> >
>
> I agree with that in general but this is bit different for below mentioned
> reason.
>
> > Did you run into a problem with finding one of the existing attributes
> > that can be used to hold the fields?
> >
>
> Not really! The 2 JEP106 codes can be used to derive the manufacturer which
> could match one of the existing attributes. However doing so might require
> importing the huge JEP106 list as it needs to be maintained and updated
> in the kernel. Also that approach will have the compatibility issue and
> that is the reason for introducing these attributes representing raw
> values for userspace.

I was thinking they codes could just be part of the normal strings rather
than get translated. Can you give an example what they would look like
with your current code?

If  you think they should be standard attributes, how about adding them
to the default list, and hardcoding them in the other soc device drivers
based on the information we have available there?

      Arnd

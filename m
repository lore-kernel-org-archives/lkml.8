Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1988AC55193
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73FA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL+MA9BT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgDWKVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:21:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB641C035493;
        Thu, 23 Apr 2020 03:21:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so2171398plp.9;
        Thu, 23 Apr 2020 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jJtnFW/MJ1nCflksmUkvWZ3WflwQQKwodxCjPDupG9g=;
        b=SL+MA9BTwa7HX9cUn2j5xDITP997LDN3HbD/qjO86/wv5xpXkNgbmjFZ8WZi9YTx78
         qgwmKScnBS+z5QiqP+VTwClgd3H2WwlvQUYePUMJZ5mA++HZrfBJzy1PN3lj/8ZLv5Dx
         IUqdoiAe3EHaIkzmnStrXgVjYV5KfhUQkyMzqiLGbki355Ax1z3SfsoqJT6THn7dg1P/
         FEUQZS4Pj2589j2HQnosfG6I0ScwYJYUta04/XZoy5MVEk2weROYwGqByZ8a0aSCwwVz
         m7We8Z4UOStTP0Qd07pXUSee+CfoTI0kk6CSoKBkTPPJVhcNf7u/oOt77R3oj2hW8CGI
         XCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jJtnFW/MJ1nCflksmUkvWZ3WflwQQKwodxCjPDupG9g=;
        b=mxF7wbJYyd6SZrHzSkVvzbyudda36n0j71Eo6dqjqFNj+1QSain8Y7iJW22DUnF+8U
         HbzPiXVIiwxDYbRRp6v1cqrKkQTwtT9L28wohwnKTd2XBN9YBXCMhIA7K3tlmlmcRJZ6
         GBM65gEXpvokM5Pc+58HWahTsxYC7qpjD/Bd3FwQE1mU4vmybsctVQnUiWIACxBig6uh
         TVWSbL9SI9h+g9BlEOw9KbSAaifOfkfhD/6HHI4A7JTUAMjgsuj1wRwPquWWxoV/DPRb
         q1SNhNPGCKqm7g0UQGTLWsMKwTKzuXyOB9y2hHoEzygiZM/RJiOi+DtwI7STBgxA7LFT
         OkCg==
X-Gm-Message-State: AGi0PubwVkdTdXXnylKZ+46XxuBP9mmbGFzYbAev4vCNmFPGdnKuBWjZ
        OPBr6eNQLMvddLX/RFJ6GTjMUKdC/JnhXmFsFyc=
X-Google-Smtp-Source: APiQypI72YMXj/eLWFT07xzy8FGvE30CVwUIO/B8ZXXxdfzcDMRlffRZbIssKJ42cgrlohzeba429xetnxfkBq9KMVA=
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr3049629plb.255.1587637273301;
 Thu, 23 Apr 2020 03:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200420194405.8281-1-jithu.joseph@intel.com> <20200420194405.8281-2-jithu.joseph@intel.com>
 <CAHp75VeV+HOditUphBkFoy6LLh6QKfBoC-eLixquAHLTwaz4RQ@mail.gmail.com> <ac04f1aa46234496fc88354add386da725d883ab.camel@intel.com>
In-Reply-To: <ac04f1aa46234496fc88354add386da725d883ab.camel@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Apr 2020 13:21:06 +0300
Message-ID: <CAHp75VfqWkAEk3deJmjBzeinmJY3MXTWVxO4FdBWyxcY8oXtAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] platform/x86: Add Slim Bootloader firmware update
 signaling driver
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 5:08 AM Jithu Joseph <jithu.joseph@intel.com> wrote=
:

...

> > > +static ssize_t firmware_update_request_store(struct device *dev,
> > > +                                            struct
> > > device_attribute *attr,
> > > +                                            const char *buf,
> > > size_t count)
> > > +{
> > > +       bool val;
> > > +       int ret;
> > > +
> > > +       ret =3D kstrtobool(buf, &val);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D set_fwu_request(dev, val ? 1 : 0);
> >
> > Hmm... If you are going to extend this, why not to pass integer
> > directly? (And thus take one from user)
>
> We have also been thinking about  extensibility =E2=80=A6
>
> So I will modify the code to allow any u32 input by the user  to be
> passed down via wmi_set_block(), though 0 and 1 will be the only
> inputs  documented  in the ABI today.( Or did you still mean  to error
> out if the user input is something other than 0 or 1 ?)

I think the best approach is to allow to parse integer input
(kstrtouint() is good enough) and return -ERANGE for values > 1. Also
put a comment before that check why is done like this (some
justification that interface may be extended in the future or so), and
pass integer value directly to set_fwu_request().

--=20
With Best Regards,
Andy Shevchenko

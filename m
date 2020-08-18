Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFDDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811662080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah6PN/pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHRRxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:53:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E3C061389;
        Tue, 18 Aug 2020 10:53:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so22433547ljk.6;
        Tue, 18 Aug 2020 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cUqbizy4/CNzstzwBk2E6Z2UAkFiz/CyA1qzSkFNX24=;
        b=ah6PN/pqjPp76RNZDb4hgdqOEyZiGpaV9HRPP2pXR2BNkS2mMJMlYIRa2khrv/9pcn
         EjdxxKNZcVJJ474rqmofPFU1o58SMKxZxwW94JEnXdDsn7gYwS5FgOqb1FAgv7Z+ImvP
         BvutB5PF9hb4Jjax1UU+7P06TbBYDymQtSLKcYmC61DkQ3OQlaDz6hlKsF0Wxx+IvRIp
         C8MrxuboGmyhM2jTpjiIQME81DHu5eE1C7Ju1ilZuN47GKxlC443qvbUyLs0uRSGktEV
         /35wKX6+FNr8370L9CF95ikY08VCEwa8MrBV0RRirH8bzyS056PP4+5A4FrzE6fKkaDs
         smxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cUqbizy4/CNzstzwBk2E6Z2UAkFiz/CyA1qzSkFNX24=;
        b=J9iq6F4NcyRP4oktG+GXFChGty2L95d3Ymol5i6Ctkt6132oZ+Vfd+K8R8DFc+I1yX
         YHC/JQf8AcI8ZQYYPWBF4bMt1zX00F4sR1v69pHrRIfW+2dCeVZvh5oyvfhfVEf8mNWQ
         i6K+pqbLkONbtZuF+4LYMfj6zA5M1dWGHlj9qKY4G8R6al2V5hNDIQeySk/8xXnwm3Aq
         ecaxVuK36l7z1C/D5+lGiQ3QA+bvx8GRQKQN4j/JgGilqMybmGP9KVklh7GGBvtDLv1x
         9b0paHt2URm6l5ukqBOgKYsU1Rnlr0+l3Alurw8qXmW5Xk3f0dflG25hK7CEjJ9kd0ax
         nC0w==
X-Gm-Message-State: AOAM532/ciivrlbjpPU4XusqBKLQju7f2vgcMwWLNsm5EyA3AhKv3Xym
        RSidKaGxMaGiAUljPg04ZbFO5QVxLULHcbfm8NyXufc3A4s=
X-Google-Smtp-Source: ABdhPJzTTtDeccC93yhyxQKuv4Aq0U8UVCSlOHVBV7VZpFFWZm79FSTGWS0NzWCDVDYFGRRB4KEDEB/0Z47oQxBxQyY=
X-Received: by 2002:a2e:b6c3:: with SMTP id m3mr10514537ljo.450.1597773212697;
 Tue, 18 Aug 2020 10:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com> <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
In-Reply-To: <20200818173656.GA748290@kroah.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Tue, 18 Aug 2020 23:23:20 +0530
Message-ID: <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
Subject: Re: Scheduler benchmarks
To:     Greg KH <greg@kroah.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> > On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> > >
> > > On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > > > On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > > > >
> > > > > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > I=E2=80=99ve two identical Linux systems with only kernel diffe=
rences.
> > > > >
> > > > > What are the differences in the kernels?
> > >
> > > You didn't answer this question, is this the same kernel source being
> > > compared here?  Same version?  Same compiler?  Everything identical?
> > Both systems are having exactly the same hardware configuration.
> > Compiler and kernel versions are different. One system has Ubuntu
> > 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
> > the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
> > version 7.5.0).
>
> Those are _very_ different kernel versions, with many years and tens of
> thousands of different changes between them.
>
> Hopefully the newer kernel is faster, so just stick with that :)
But unfortunately the newer kernel is very slow, that is the reason
for starting this investigation :)
Any type of help,  and guidelines to dive deeper will be highly appreciated=
.

>
> greg k-h



--=20
Thanks,
Sekhar

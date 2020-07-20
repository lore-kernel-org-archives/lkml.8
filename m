Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A57C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A622BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8eXAjIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGTNIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:08:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41511 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbgGTNIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595250502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnI6z9XD4HROXBuf4ZFEC55TsWlw3nYumyPptKBD5+U=;
        b=a8eXAjIK8yMU7NyqWyDSnIAQ5HJuxdho2XePJMWP0NYLhS2MMmSU0peWYUQtas99YlhRSn
        F6lL+h1dP68H57yKGKSULH19pwWBOQydWLTvR4tNBIGKcuLgPU5iNVJ/Rt0J16P2j9L9Ey
        pN1TSueWPWqT+dDzbJiLRltmsKK42U0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Q6-AbQBIN4q75xguUsZmyQ-1; Mon, 20 Jul 2020 09:08:20 -0400
X-MC-Unique: Q6-AbQBIN4q75xguUsZmyQ-1
Received: by mail-qk1-f198.google.com with SMTP id h4so11341301qkl.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZnI6z9XD4HROXBuf4ZFEC55TsWlw3nYumyPptKBD5+U=;
        b=qztPP4h3FCcx1/q20PFBm/BrO33vAVjWB1hQOiFeqBoK8LXUqSh3eVVdt0j72R79G7
         pded28OvAGomLGFq3MumqR45uNzEEnaWllWduymJ9dY1Swtko6/Lcko0Ft7fdQV5wYfA
         6M17ehb9/vbt8ImLGTYwpd1VuuWoj63XrFbbdyp0HYcONJZqdmSC3I6su2GmWYOwxf0c
         YsaLC1Ldn3j0aOawc4ojUNwKqbLMhtQhWYh+CS0O8Lh9f5j5IKz2BIuCXF+d6EBDYE46
         LQPLPZbMzuX4kOYIIBUS8vPBFjB0TJje0UR23YepvdF7teP21s6nzFRiktN564/ZYdYz
         o4sA==
X-Gm-Message-State: AOAM530d1dGaVErJ0xCmn2dfpLM3Eoj4AA48HI81799acGG6RdgTbDjh
        6yXZgtGgl29j+UEbmpH+/IjsorJNBRgMUmD0wtBhAeDH+AWWz0yoe7HqKpvQ5BckcwuXaGudmoa
        LKFYn3CW2qZG9fmW5b2RHKon41kaj/3RylAonn1Cj
X-Received: by 2002:a37:8305:: with SMTP id f5mr9965764qkd.497.1595250500206;
        Mon, 20 Jul 2020 06:08:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+qL5VQ7P0iLbnRiSz18JGObnRiei2eT7j7NLOkvfJpRf4REAM1dZ7Q/8SKrI8G1PKv7Jbhz05Pv7AXpAZZlg=
X-Received: by 2002:a37:8305:: with SMTP id f5mr9965728qkd.497.1595250499886;
 Mon, 20 Jul 2020 06:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200622122546-mutt-send-email-mst@kernel.org>
 <CAJaqyWfbouY4kEXkc6sYsbdCAEk0UNsS5xjqEdHTD7bcTn40Ow@mail.gmail.com>
 <CAJaqyWefMHPguj8ZGCuccTn0uyKxF9ZTEi2ASLtDSjGNb1Vwsg@mail.gmail.com>
 <419cc689-adae-7ba4-fe22-577b3986688c@redhat.com> <CAJaqyWedEg9TBkH1MxGP1AecYHD-e-=ugJ6XUN+CWb=rQGf49g@mail.gmail.com>
 <0a83aa03-8e3c-1271-82f5-4c07931edea3@redhat.com> <CAJaqyWeqF-KjFnXDWXJ2M3Hw3eQeCEE2-7p1KMLmMetMTm22DQ@mail.gmail.com>
 <20200709133438-mutt-send-email-mst@kernel.org> <7dec8cc2-152c-83f4-aa45-8ef9c6aca56d@redhat.com>
 <CAJaqyWdLOH2EceTUduKYXCQUUNo1XQ1tLgjYHTBGhtdhBPHn_Q@mail.gmail.com>
 <20200710015615-mutt-send-email-mst@kernel.org> <CAJaqyWf1skGxrjuT9GLr6dtgd-433y-rCkbtStLHaAs2W2jYXA@mail.gmail.com>
 <595d4cf3-2b15-8900-e714-f3ebd8d8ca2e@redhat.com>
In-Reply-To: <595d4cf3-2b15-8900-e714-f3ebd8d8ca2e@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 20 Jul 2020 15:07:43 +0200
Message-ID: <CAJaqyWfr0xQQNFptQbt1mVHrBGnFHjU3Qme-hsXNHkEkC6OkBQ@mail.gmail.com>
Subject: Re: [PATCH RFC v8 02/11] vhost: use batched get_vq_desc version
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:55 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/7/17 =E4=B8=8A=E5=8D=881:16, Eugenio Perez Martin wrote:
> > On Fri, Jul 10, 2020 at 7:58 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >> On Fri, Jul 10, 2020 at 07:39:26AM +0200, Eugenio Perez Martin wrote:
> >>>>> How about playing with the batch size? Make it a mod parameter inst=
ead
> >>>>> of the hard coded 64, and measure for all values 1 to 64 ...
> >>>>
> >>>> Right, according to the test result, 64 seems to be too aggressive i=
n
> >>>> the case of TX.
> >>>>
> >>> Got it, thanks both!
> >> In particular I wonder whether with batch size 1
> >> we get same performance as without batching
> >> (would indicate 64 is too aggressive)
> >> or not (would indicate one of the code changes
> >> affects performance in an unexpected way).
> >>
> >> --
> >> MST
> >>
> > Hi!
> >
> > Varying batch_size as drivers/vhost/net.c:VHOST_NET_BATCH,
>
>
> Did you mean varying the value of VHOST_NET_BATCH itself or the number
> of batched descriptors?
>
>
> > and testing
> > the pps as previous mail says. This means that we have either only
> > vhost_net batching (in base testing, like previously to apply this
> > patch) or both batching sizes the same.
> >
> > I've checked that vhost process (and pktgen) goes 100% cpu also.
> >
> > For tx: Batching decrements always the performance, in all cases. Not
> > sure why bufapi made things better the last time.
> >
> > Batching makes improvements until 64 bufs, I see increments of pps but =
like 1%.
> >
> > For rx: Batching always improves performance. It seems that if we
> > batch little, bufapi decreases performance, but beyond 64, bufapi is
> > much better. The bufapi version keeps improving until I set a batching
> > of 1024. So I guess it is super good to have a bunch of buffers to
> > receive.
> >
> > Since with this test I cannot disable event_idx or things like that,
> > what would be the next step for testing?
> >
> > Thanks!
> >
> > --
> > Results:
> > # Buf size: 1,16,32,64,128,256,512
> >
> > # Tx
> > # =3D=3D=3D
> > # Base
> > 2293304.308,3396057.769,3540860.615,3636056.077,3332950.846,3694276.154=
,3689820
>
>
> What's the meaning of buf size in the context of "base"?
>

Hi Jason.

I think that all the previous questions have been answered in the
response to MST, please let me know if I missed something.

> And I wonder maybe perf diff can help.

Great, I will run it too.

Thanks!

>
> Thanks
>
>
> > # Batch
> > 2286723.857,3307191.643,3400346.571,3452527.786,3460766.857,3431042.5,3=
440722.286
> > # Batch + Bufapi
> > 2257970.769,3151268.385,3260150.538,3379383.846,3424028.846,3433384.308=
,3385635.231,3406554.538
> >
> > # Rx
> > # =3D=3D
> > # pktgen results (pps)
> > 1223275,1668868,1728794,1769261,1808574,1837252,1846436
> > 1456924,1797901,1831234,1868746,1877508,1931598,1936402
> > 1368923,1719716,1794373,1865170,1884803,1916021,1975160
> >
> > # Testpmd pps results
> > 1222698.143,1670604,1731040.6,1769218,1811206,1839308.75,1848478.75
> > 1450140.5,1799985.75,1834089.75,1871290,1880005.5,1934147.25,1939034
> > 1370621,1721858,1796287.75,1866618.5,1885466.5,1918670.75,1976173.5,198=
8760.75,1978316
> >
> > pktgen was run again for rx with 1024 and 2048 buf size, giving
> > 1988760.75 and 1978316 pps. Testpmd goes the same way.
> >
>


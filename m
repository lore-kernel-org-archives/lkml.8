Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88856C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C32A20674
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="n/I/jA2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gg4TdrQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgHRRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:36:50 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39323 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728889AbgHRRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:36:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3494A10A8;
        Tue, 18 Aug 2020 13:36:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 18 Aug 2020 13:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=9
        TlfznyxsMv5GMFDcfPOM5mcVt7VYPmD7P4p5Aa1ggA=; b=n/I/jA2sR7EdLT4fM
        sdG8+/6f5iDm80zA9fnUvSoAe+dUsK94q3XUGCycovf4oIeDyYVAyHVh/JXLGfJC
        yahhcQ2zWxL3srqei7NxqOZK0lz+2mmLS+QZKvsRtv9PfnqhTt6wPdagpV80d4e+
        iLPzzTDlone/3uKJcSNXU3Ktth+Ua/Fm+JI7PY6vMX7x1jFuOvIWn3VTVLf+wwzS
        H5N4/AiQxVRXvtfEFjJdsdWW2V5t+jrT3k89QZooxNrLvUYVbLcigf5u/zApyJKs
        rk8p7cSnsZvwJnC1tFxoe2IaBFA07qFanpUrpjzkBEyMhPYXu39Z4+0DRARujkG3
        ryyEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9TlfznyxsMv5GMFDcfPOM5mcVt7VYPmD7P4p5Aa1g
        gA=; b=Gg4TdrQeB2iojmFKU7oK1ICjlmbsrX1Ru1wI0Uc2mGdq9OarkJHAUOMhD
        z+siCAVbI1uSReLu4adjAcDNx46kCuADYZ/nlXxWlHFKtz2amNNX0CERhef/1w/h
        d5V1uNeiEd7aQixuDKmYy/IRolckpqT0JExmCVf/6XUizADVEVchml3AG4IYI5Gw
        dlxEpMYdo3swERA4HE8pDD6LfAlnH41s8AmmAfv4K09ebngM/WmIYGxPCld663Ym
        RihXPTkqblSCclFI+U4uMpoDJ+Z5w83pma18GsTbjIKjjnzA1SrtLqU2f2YsGoTI
        7voPF5A7qLNEc30xedntAKCqmrawg==
X-ME-Sender: <xms:oRE8X_3osVoQ4g4vq8-lY1_6aDeZbIyRo37qQyXNW4LE0effnH-_ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuheekheelffefieduteefkeejffdvueehjeejffehle
    dugfetkedvleekudduvdenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:oRE8X-GdRey3VoRTH_FFEpSxg82SP2l2tYGyDAiU3lfOm_Z_WVRLWQ>
    <xmx:oRE8X_62SMZdRXyMIsaGim_en4k1uVSPcSalIJxhq7n-trqUyj-nuQ>
    <xmx:oRE8X02Kafx4DGYnvA9bd5kXv8ADhE0sJU1vGj9bJ8dfgjCPUlCE2A>
    <xmx:oRE8X9N1ChapT9PIU622iyLJkerjQsZaZ46HOcar9JcQqy9WoWahBA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E2693060272;
        Tue, 18 Aug 2020 13:36:33 -0400 (EDT)
Date:   Tue, 18 Aug 2020 19:36:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
Message-ID: <20200818173656.GA748290@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
> > > On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
> > > >
> > > > On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
> > > > > Hi all,
> > > > >
> > > > > I’ve two identical Linux systems with only kernel differences.
> > > >
> > > > What are the differences in the kernels?
> >
> > You didn't answer this question, is this the same kernel source being
> > compared here?  Same version?  Same compiler?  Everything identical?
> Both systems are having exactly the same hardware configuration.
> Compiler and kernel versions are different. One system has Ubuntu
> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
> version 7.5.0).

Those are _very_ different kernel versions, with many years and tens of
thousands of different changes between them.

Hopefully the newer kernel is faster, so just stick with that :)

greg k-h

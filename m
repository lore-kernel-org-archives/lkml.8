Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32851C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECE520781
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="dQhr/310"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgF2Wqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:46:45 -0400
Received: from smtp99.iad3a.emailsrvr.com ([173.203.187.99]:36501 "EHLO
        smtp99.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728308AbgF2Wqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593470802;
        bh=ahKIpp3T71zR6TCFh1/inNBMliSekqSWI6mRHYvVqq4=;
        h=Date:Subject:From:To:From;
        b=dQhr/310r/S+LV5yWz8ticsWTrTCTk8hZumnuzBovXIwJp9UHQe4jOT7tRMFpiSz+
         ICgjV33wXOH+HiuioI3/Zklgb/oOkrFU056tabwEpR8E6Hgva+DEiZjv/zZimdGtyK
         XBRud5D+HZo8NtdP5dWC5wh5GLfjW0vdM7cxllV4=
Received: from app51.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp21.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id AAC3924E9E;
        Mon, 29 Jun 2020 18:46:41 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app51.wa-webapps.iad3a (Postfix) with ESMTP id 957C8A13EB;
        Mon, 29 Jun 2020 18:46:41 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Mon, 29 Jun 2020 18:46:41 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Mon, 29 Jun 2020 18:46:41 -0400 (EDT)
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Sean Christopherson" <sean.j.christopherson@intel.com>
Cc:     "Andy Lutomirski" <luto@amacapital.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "X86 ML" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Allison Randal" <allison@lohutok.net>,
        "Enrico Weigelt" <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "=?utf-8?Q?Peter_Zijlstra_=28Intel=29?=" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Martin Molnar" <martin.molnar.programming@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        "Jann Horn" <jannh@google.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
In-Reply-To: <20200629214956.GA12962@linux.intel.com>
References: <1593464072.34968499@apps.rackspace.com> 
 <0AFABBBA-18B7-4E2F-BCE7-D69889CC0F79@amacapital.net> 
 <20200629214956.GA12962@linux.intel.com>
Message-ID: <1593470801.608531492@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: db414326-9724-44a0-90e2-83df0980473c-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=0AOn Monday, June 29, 2020 5:49pm, "Sean Christopherson" <sean.j.christ=
opherson@intel.com> said:=0A=0A> On Mon, Jun 29, 2020 at 02:22:45PM -0700, =
Andy Lutomirski wrote:=0A>>=0A>>=0A>> > On Jun 29, 2020, at 1:54 PM, David =
P. Reed <dpreed@deepplum.com> wrote:=0A>> >=0A>> > =EF=BB=BFSimple question=
 for those on the To: and CC: list here. Should I=0A>> > abandon any hope o=
f this patch being accepted? It's been a long time.=0A>> >=0A>> > The non-r=
esponse after I acknowledged that this was discovered by when=0A>> > workin=
g on a personal, non-commercial research project - which is=0A>> > "out-of-=
tree" (apparently dirty words on LKML) has me thinking my=0A>> > contributi=
on is unwanted. That's fine, I suppose. I can maintain this patch=0A>> > ou=
t-of-tree as well.  I did incorporate all the helpful suggestions I=0A>> > =
received in this second patch, and given some encouragement, will happily=
=0A>> > submit a revised v3 if there is any likelihood of acceptance. I'm w=
ary of=0A>> > doing more radical changes (like combining emergency and norm=
al paths).=0A>> >=0A>>=0A>> Sorry about being slow and less actively encour=
aging than we should be. We=0A>> absolutely welcome personal contributions.=
 The actual problem is that=0A>> everyone is worked and we=E2=80=99re all s=
low. Also, you may be hitting a corner=0A>> case=0A>> in the process: is th=
is a KVM patch or an x86 patch?=0A> =0A> It's an x86 patch as it's not KVM =
specific, e.g. this code also helps play=0A> nice with out of tree hypervis=
ors.=0A> =0A> The code change is mostly good, but it needs to be split up a=
s there are=0A> three separate fixes:=0A> =0A>   1. Handle #UD on VMXON due=
 to a race.=0A>   2. Mark memory and flags as clobbered by VMXON.=0A>   3. =
Change emergency_vmx_disable_all() to not manually check cpu_vmx_enabled().=
=0A> =0A> Yes, the changes are tiny, but if for example #3 introduces a bug=
 then we=0A> don't have to revert #1 and #2.  Or perhaps older kernels are =
only subject=0A> to the #1 and #2 and thus dumping all three changes into a=
 single patch makes=0A> it all harder to backport.  In other words, all the=
 usual "one change per=0A> patch" reasons.=0A> =0AThanks. If no one else re=
sponds with additional suggestions, I will make it into 3 patches.=0AI'm ha=
ppy to learn the nuances of the kernel patch regimen.=0A=0A


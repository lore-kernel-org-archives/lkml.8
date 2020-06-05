Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38979C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F083206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKS7TeTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFEAZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:25:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgFEAZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591316751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBC+3Rh493Pihk2TfJshByWqqAzGsz2M8F7u+obL4Tc=;
        b=OKS7TeTtbRHd9l/908udv4Eef++VEm2rk8Bykn8uIfvWsDSYorX1cr84Sx/mphPsvI6xdf
        beOHpXqOly2p3yQAMi+sIv56fO9xCm++euDeqgbu+/JIqVGUWR2fSnG020FgWu6AXQXtvV
        hqyEK8i7P0r5c2CxgepdkCNLtZk8WYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-s0x6UcCjP9GH6n4q5rdQTA-1; Thu, 04 Jun 2020 20:25:49 -0400
X-MC-Unique: s0x6UcCjP9GH6n4q5rdQTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ECC11854C46;
        Fri,  5 Jun 2020 00:25:48 +0000 (UTC)
Received: from localhost (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4099C5D9D3;
        Fri,  5 Jun 2020 00:25:45 +0000 (UTC)
Date:   Fri, 5 Jun 2020 02:25:41 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Liu Yiding <yidingx.liu@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [netfilter] e32a4dc651:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <20200605022541.3d702fe1@redhat.com>
In-Reply-To: <7dd4f0d2-34a7-8086-99cb-424ff2e039ca@intel.com>
References: <20200603084934.GF12456@shao2-debian>
        <20200605002323.501b1cc6@redhat.com>
        <7dd4f0d2-34a7-8086-99cb-424ff2e039ca@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 08:15:07 +0800
Liu Yiding <yidingx.liu@intel.com> wrote:

> Hi,
>=20
> On 6/5/20 6:23 AM, Stefano Brivio wrote:
> > Hi,
> >
> > On Wed, 3 Jun 2020 16:49:34 +0800
> > kernel test robot <lkp@intel.com> wrote:
> > =20
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-7):
> >>
> >> commit: e32a4dc6512ce3c1a1920531246e7037896e510a ("netfilter: nf_table=
s: make sets built-in")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>
> >> in testcase: kernel-selftests
> >> with following parameters:
> >>
> >> 	group: kselftests-netfilter =20
> > I couldn't find this information in the report. Would it be possible to
> > have here an indication of what kselftest specifically is failing?
> > There are a number of tests in that group. I have an obvious suspicion
> > here (nft_concat_range.sh), but it would be nice to know, in general. =
=20
>=20
> Yes, it's nft_concat_range.sh caused this error.
>=20
> ```
>=20
> [=C2=A0 165.249447] # selftests: netfilter: nft_concat_range.sh
> [=C2=A0 165.249453]
> [=C2=A0 165.295336] # TEST: reported issues
> [=C2=A0 165.295342]
> [=C2=A0 165.316525] BUG: using smp_processor_id() in preemptible [0000000=
0]=20
> code: nft/6247
> [=C2=A0 165.319547] caller is nft_pipapo_insert+0x464/0x610 [nf_tables]
> [=C2=A0 165.321846] CPU: 1 PID: 6247 Comm: nft Not tainted=20
> 5.6.0-rc5-01595-ge32a4dc6512ce3 #1
>=20
> ```

Thanks for confirming. I think it would really be helpful to have the
specific test name in the report, in the future.

> And i think this error is caused by some kconfigs.
>
> This test was passed until we enabled all kconfigs defined in=20
> netfilter/config. :-(

Then most likely this was CONFIG_NF_TABLES_SET not enabled, which goes
away with Florian's commit e32a4dc6512c as the whole feature is now
built in.

--=20
Stefano


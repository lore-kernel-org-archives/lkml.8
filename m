Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5751C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB97A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G7U8FtkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD2N36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:29:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:54108 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgD2N35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:29:57 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200429132953epoutp03c817c79ae9a47f8cf68db986b4513698~KTXdao9m71772517725epoutp03Y
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:29:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200429132953epoutp03c817c79ae9a47f8cf68db986b4513698~KTXdao9m71772517725epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588166993;
        bh=bRJD56f6pzR4JP4rnoQPwDkBm83a1p4ix7tEGPLNyh4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=G7U8FtkB/ZVuGHoXsGuRWOEFoU/53ufkXmN3nD/b47MGBfxWqGTZ/cw2LxvxJlq9L
         83ChIwW2mZaADWfgzzq55SuDLeBJ8sXXfpgQOzpIoSkifvEAh6j+C0ArCw8jOPrZa2
         b7CpXdlzkJgFBTKmg7hJimmWV3ISbUzqJoFVqDsg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200429132952epcas5p2f2f6139c88baf79b23f33bb700be47c9~KTXciH31m1812418124epcas5p2w;
        Wed, 29 Apr 2020 13:29:52 +0000 (GMT)
X-AuditID: b6c32a4b-ae3ff70000001280-ea-5ea9815013b7
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.3B.04736.05189AE5; Wed, 29 Apr 2020 22:29:52 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 1/1] mm/vmscan.c: change prototype for
 shrink_page_list
Reply-To: v.narang@samsung.com
From:   Vaneet Narang <v.narang@samsung.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Maninder Singh <maninder1.s@samsung.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200429130912.GE28637@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200429132940epcms5p81e75e09469b62253ff512222c568556f@epcms5p8>
Date:   Wed, 29 Apr 2020 18:59:40 +0530
X-CMS-MailID: 20200429132940epcms5p81e75e09469b62253ff512222c568556f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7bCmpm5A48o4g4n3FS0u7k61mLN+DZvF
        5V1z2CzurfnPanF4fhuLxetvy5gd2Dw2reoEEp8msXucmPGbxaNvyypGj8+b5AJYo7hsUlJz
        MstSi/TtErgy9p6dz1xwXrhi07+lrA2MPcJdjJwcEgImElNeNDN2MXJxCAnsZpQ4u62BtYuR
        g4NXQFDi7w6wGmGBAImfT48zg9hCAnISx2/sZoSI60icmLeGEaScTUBL4mNLOEhYBKj8efM6
        FpCRzAIXGSXmTF3ADrGLV2JG+1MWCFtaYvvyrWBzOIFueLJtIhtEXFTi5uq37DD2+2PzGSFs
        EYnWe2eZIWxBiQc/d0PFZSS+f+1nBVkmIdDNKPF5Sx8bhDOFUWL279NMEFXmErs3zGOBeMxX
        YuEzB5Awi4CqxPbmCVCDXCT6Jh0FW8AsoC2xbOFrZpByZgFNifW79CFKZCWmnlrHBFHCJ9H7
        +wkTzF875sHYShLnDu6E+kVC4knnTLAxEgIeEremMkOCeTmTxJKXX1knMCrMQoT0LCSLZyEs
        XsDIvIpRMrWgODc9tdi0wDgvtVyvODG3uDQvXS85P3cTIzi1aHnvYNx0zucQowAHoxIPr0Xq
        yjgh1sSy4srcQ4wSHMxKIryPMpbFCfGmJFZWpRblxxeV5qQWH2KU5mBREufVYgSqFkhPLEnN
        Tk0tSC2CyTJxcEo1MPJpX947Z1bF+zW5zk8+KU7/xl32g/dZbzT/tU/amfZGS06ZPK34MO0l
        o+P99ouG6bmCe672nZVaoHt+Q8rKtZlPhL183/M++LpyzltZYcGHlZ8ftew8tD/wfqbHjnlL
        X1jLr0q48FFua5TqjO9hwtvzmzTWP2gQebnp5yVXZxXj3bM/q08yT3qixFKckWioxVxUnAgA
        h9kI6ykDAAA=
X-CMS-RootMailID: 20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c
References: <20200429130912.GE28637@dhcp22.suse.cz>
        <20200429120951.GC28637@dhcp22.suse.cz>
        <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
        <20200429125323epcms5p67a539511c573cd598d78b726503e3204@epcms5p6>
        <CGME20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c@epcms5p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,=C2=A0=0D=0A=0D=0A>>=C2=A0>=0D=0A>>=C2=A0>Acked-by:=C2=A0Michal=
=C2=A0Hocko=C2=A0<mhocko=40suse.com>=0D=0A>>=C2=A0>=0D=0A>>=C2=A0>Is=C2=A0t=
here=C2=A0any=C2=A0reason=C2=A0to=C2=A0move=C2=A0declarations=C2=A0here?=0D=
=0A>>=C2=A0>=0D=0A>>=C2=A0=0D=0A>>=C2=A0=22unsigned=C2=A0int=C2=A0ret=22=C2=
=A0was=C2=A0changed=C2=A0mistakenely,=C2=A0sending=C2=A0V2.=0D=0A>>=C2=A0an=
d=C2=A0=22unsigned=C2=A0int=C2=A0nr_reclaimed=22=C2=A0is=C2=A0changed=C2=A0=
to=C2=A0remove=C2=A0hole.=0D=0A=C2=A0=0D=0A>Could=C2=A0you=C2=A0be=C2=A0mor=
e=C2=A0specific?=C2=A0Have=C2=A0you=C2=A0seen=C2=A0a=C2=A0better=C2=A0stack=
=C2=A0allocation=0D=0A>footprint?=0D=0A=0D=0AWe=20didn't=20check=20stack=20=
allocation=20footprint,=20we=20did=20changes=20just=20by=20looking=20into=
=20the=20code.=0D=0Awe=20thought=20changing=20reclaimed=20type=20from=20lon=
g=20to=20int=20on=2064=20bit=20platform=20will=20add=20=0D=0Ahole=20of=204=
=20bytes=20between=20two=20stack=20variables=20nr_reclaimed=20&=20nr_taken.=
=0D=0A=0D=0ASo=20we=20tried=20to=20remove=20that=20hole=20by=20packing=20it=
=20with=20bool.=0D=0A=0D=0A=20=09unsigned=20long=20nr_scanned;=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20-->=20Size=20and=20alignment=208=20b=
yte=20for=20long=20=0D=0A-=09unsigned=20long=20nr_reclaimed=20=3D=200;=20=
=20=20=20=20=20=20=20=20=20=20-->=20Changing=20to=20int=20will=20make=20its=
=20size=20as=204=20=20=0D=0A=20=09unsigned=20long=20nr_taken;=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20-->=20nr_taken=20needs=20align=
ment=20of=208=20so=20will=20add=20hole.=0D=0A=20=09struct=20reclaim_stat=20=
stat;=0D=0A=20=09int=20file=20=3D=20is_file_lru(lru);=0D=0A=20=09enum=20vm_=
event_item=20item;=0D=0A=20=09struct=20pglist_data=20*pgdat=20=3D=20lruvec_=
pgdat(lruvec);=0D=0A=20=09struct=20zone_reclaim_stat=20*reclaim_stat=20=3D=
=20&lruvec->reclaim_stat;=0D=0A+=09unsigned=20int=20nr_reclaimed=20=3D=200;=
=20=20=20=20=20=20=20=20=20=20=20=20-->=20So=20moving=20to=20this=20place=
=20to=20pack=20it=20along=20with=20bool=20=0D=0A=20=09bool=20stalled=20=3D=
=20false;=0D=0A=0D=0A=0D=0AOverall=20stack=20footprint=20might=20not=20chan=
ge=20as=20compiler=20makes=20function=20stack=20pointer=20as=2016=20byte=20=
aligned=20but=20we=20did=20this=20=0D=0Aas=20we=20normally=20follow=20this=
=20coding=20convention=20when=20defining=20structures=20or=20stack=20variab=
les.=20=0D=0A=0D=0AThanks=20&=20Regards,=0D=0AVaneet=20Narang=0D=0A=C2=A0=
=0D=0A=C2=A0=0D=0A=0D=0A=C2=A0

Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490C620C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="L3x+VuPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgIGS4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:56:50 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:15632 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729273AbgIGSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:07 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087ImijH008552;
        Mon, 7 Sep 2020 18:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject; s=pps0720;
 bh=QMaOOaxAJFnx885+/Mk4aDk9Z7mxErmyR/72sMnGDvM=;
 b=L3x+VuPvDRFkyowAgq8wFVVaP9CI9Z/KT4MxWimb24AkeEue59RKvE0k6pdCsIXQejf3
 QqwmApTB7kusmM75ut6qoAXjLUZj9e6clEWlTP2+PEDRj9WONxaj5oovM/qYxbuqxhlb
 pQ/zPdv3IIwfQ3MB0KRLSvnUmykL4/CyI1YBXOxFTJXuZVX2xddK6GhoY4tfGatpuAyp
 2J1Uvqnd3egGdR6YFiKqWTRoawhvX35Sg+R2Dw3ACQ/RF6bocEOUE7MxabkQiQE8Qqo4
 n+gTn4puHdlbVUhB84L7K/h14gzfZrtF9OS2BL64ZCldjZuwf01+DZWcNTX2cU4Qk5Po RA== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 33c3b32273-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:32 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 42E7960;
        Mon,  7 Sep 2020 18:54:31 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 78D1D302F4600; Mon,  7 Sep 2020 13:54:30 -0500 (CDT)
Message-ID: <20200907185430.363197758@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:30 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/12] x86/platform/uv: Updates for UV5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=66 spamscore=66 mlxlogscore=-28
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=66 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 00/12] x86/platform/uv: Updates for UV5

Add changes needed for new UV5 UV architecture.  Chief among the changes
are 52 bits of physical memory address and 57 bits of virtual address space.  

0001 Remove UV BAU TLB Shootdown Handler
    - removes BAU TLB code being replaced by BAU APIC driver

0002 Remove SCIR built in driver
    - removes System Controller (monitoring) code

0003 Update UV kernel modules
    - update loadable UV kernel modules prior to a clash of symbols
      (is_uv) produced by auto-generated UV5 uv_mmrs.h file

0004 Update UV MMRs for UV5
    - update uv_mmrs.h file and fix resultant compiler errors

0005 Add UV5 direct references
    - add references to UV5 specific values

0006 Decode and Use Arch Type in UVsystab
    - add UV ArchType field to UVsystab to remove dependency on OEM_ID

0007 Update MMIOH references
    - display MMIOH mapping for each MMIOH region

0008 Adjust GAM MMR references
    - update GAM mapping for MMR accesses

0009 Update UV GRU references
    - update GRU mapping to include UV5

0010 Update Node Present Counting
    - UV5 changes method of counting nodes present

0011 Update UV5 TSC Checking
    - update TSC sync check of BIOS sync status

0012 Update for UV5 NMI MMR changes
    - update NMI handler


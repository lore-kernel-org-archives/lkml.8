Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD644C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB5121548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394812AbgFSSKG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:10:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732403AbgFSSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:10:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JI4ZNo013853
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:10:04 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rwwu0s1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:10:04 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <miltonm@us.ibm.com>;
        Fri, 19 Jun 2020 18:10:03 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 19 Jun 2020 18:09:55 -0000
Received: from us1a3-mail228.a3.dal06.isc4sb.com ([10.146.103.71])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2020061918095479-734599 ;
          Fri, 19 Jun 2020 18:09:54 +0000 
In-Reply-To: <20200619165154.GA20461@cnn>
From:   "Milton Miller II" <miltonm@us.ibm.com>
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, manikandan.e@hcl.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        vijaykhemka@fb.com, saipsdasari@fb.com, patrickw3@fb.com
Date:   Fri, 19 Jun 2020 18:09:55 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200619165154.GA20461@cnn>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 37575
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20061918-4409-0000-0000-00000305A032
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.424974; ST=0; TS=0; UL=0; ISC=; MB=0.000960
X-IBM-SpamModules-Versions: BY=3.00013312; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01393884; UDB=6.00746056; IPR=6.01176167;
 MB=3.00032629; MTD=3.00000008; XFM=3.00000015; UTC=2020-06-19 18:10:01
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-06-19 16:54:29 - 6.00011502
x-cbparentid: 20061918-4410-0000-0000-00006256AC0D
Message-Id: <OFB20C104E.283BBF6D-ON0025858C.0062CC5B-0025858C.0063C8F2@notes.na.collabserv.com>
Subject: Re:  [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_20:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On : 06/19/2020 abiout 12:46PM in some timezone,  Manikandan Elumalai  wrote:

>The adm1278 temp attribute need it for openbmc platform .
>This feature not enabled by default, so PMON_CONFIG needs to enable
>it.
>
>Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
>---
>---    v4 -Reported-by: kernel test robot <lkp@intel.com>

Thie above tag should be Adjacent to the Signed-off-by.

>---    v3 -fix invalid signed-off.
>---       -removed checkpath warnings.
>---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single
>line operation.
>---    v2 -add Signed-off-by.
>---       -removed ADM1278_TEMP1_EN check.
>---

The canonical format is to have a line of 3 dashes then the trailing changelog 

Please read the documentation at 

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

milton


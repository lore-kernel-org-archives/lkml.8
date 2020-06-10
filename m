Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E791C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4E72074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgFJLVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:21:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728322AbgFJLVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:21:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AB4Ypg116490;
        Wed, 10 Jun 2020 07:21:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31jkrgtuuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 07:21:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ABLSrV006580;
        Wed, 10 Jun 2020 11:21:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7yjea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 11:21:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05ABLT0D7799170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 11:21:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F495204E;
        Wed, 10 Jun 2020 11:21:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 863D55205F;
        Wed, 10 Jun 2020 11:21:29 +0000 (GMT)
Received: from localhost (unknown [9.206.222.209])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 51A32A0217;
        Wed, 10 Jun 2020 21:21:28 +1000 (AEST)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/svm: Fixup align argument in alloc_shared_lppaca() function
In-Reply-To: <20200609113909.17236-1-sathnaga@linux.vnet.ibm.com>
References: <20200609113909.17236-1-sathnaga@linux.vnet.ibm.com>
Date:   Wed, 10 Jun 2020 21:21:49 +1000
Message-ID: <87imfzf9o2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_07:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=1 clxscore=1015 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxlogscore=840 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:
> Argument "align" in alloc_shared_lppaca() function was unused inside the
> function. Let's fix it and update code comment.

I think it would be better to drop the align argument entirely and keep
that logic, and the comment, internal to alloc_shared_lppaca().

cheers

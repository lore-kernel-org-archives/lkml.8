Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38603206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gjfu7OY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgE1KFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:05:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387597AbgE1KFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:05:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SA1O6v135021;
        Thu, 28 May 2020 06:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=de8C/Le/tmh5vqYbCaE1NMQrFIKhJEo1ATNxsabAwnk=;
 b=gjfu7OY9YL6HQh9E7ARGj2df5ZYlIlyRjFIdRXk8dGMVBWT08WXOcwG1kcCQb9KEzlbM
 uXwC+RQQ0A839Isb0wlGG88y2ZN98AxqbFcs7Id/FailSujFGlkqMwBiRy/u7EGRRj1J
 wiBtrueDAYUS/KmPNKxuTLceeeFtxF0SO91lpRuMh5NzHNOxRwLbHiFVKpILeLsnOCSC
 WDv9z5eV2G03812DeHxIe8DDjo2g4GJ8bAM9hyVAlOo4acK2YLDB2TtPuhy0pnpHK8Z1
 HpUmU4uyjrqddYdhBzfLI1WoT3kJs8nW/kyGIJyS/YLVEHhcLg6bk1oyQ9Hg7iDesDKp YA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31a9nb37uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 06:05:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04S9jL5U021886;
        Thu, 28 May 2020 10:05:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 316uf89nv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:05:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04SA5gZ823789708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 10:05:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E05111C058;
        Thu, 28 May 2020 10:05:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF1F511C050;
        Thu, 28 May 2020 10:05:41 +0000 (GMT)
Received: from localhost (unknown [9.145.63.210])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 28 May 2020 10:05:41 +0000 (GMT)
Date:   Thu, 28 May 2020 12:05:40 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
Message-ID: <your-ad-here.call-01590660340-ext-2669@work.hours>
References: <20200522183922.5253-1-ptesarik@suse.com>
 <20200528110813.7eb1fc1f@ezekiel.suse.cz>
 <595c993e-0be4-3164-2498-b915c3fc9726@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <595c993e-0be4-3164-2498-b915c3fc9726@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=517 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:01:45PM +0200, Pierre Morel wrote:
> 
> On 2020-05-28 11:08, Petr Tesarik wrote:
> > Hi all,
> > 
> > just a gentle ping.
> > 
> > If the current behaviour (logging the original handle) was intended,
> > then it was worth mentioning in the commit message for 17cdec960cf77,
> > which made the change, but since that's no longer an option, I'd be
> > happy with an explanation in email.
> > 
> > Petr T
> > 
> > On Fri, 22 May 2020 20:39:22 +0200
> > Petr Tesarik <ptesarik@suse.com> wrote:
> > 
> > > After disabling a function, the original handle is logged instead of
> > > the disabled handle.
> 
> Hi Petr,
> 
> Sorry for the delay, no doubt, you are right, the fh in zpci_dbg is the old
> one and we should use the one in the zdev struct.
> 
> Thanks,
> Pierre
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Applied, thanks

Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E9C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903420774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCZKEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:04:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgCZKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:04:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QA4L1D067938
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:04:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf3hegbc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:04:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anton@linux.ibm.com>;
        Thu, 26 Mar 2020 10:04:07 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Mar 2020 10:04:03 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02QA44PS53543110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 10:04:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6388BA4057;
        Thu, 26 Mar 2020 10:04:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 115F6A4051;
        Thu, 26 Mar 2020 10:04:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Mar 2020 10:04:04 +0000 (GMT)
Received: from kryten.localdomain (unknown [9.102.47.109])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 28037A023A;
        Thu, 26 Mar 2020 21:03:58 +1100 (AEDT)
Date:   Thu, 26 Mar 2020 21:04:01 +1100
From:   Anton Blanchard <anton@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ulrich Weigand <uweigand@de.ibm.com>, paulmck@kernel.org,
        jejb@linux.ibm.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: provide IBM contacts for embargoed
 hardware
In-Reply-To: <20200326094241.GA996751@kroah.com>
References: <20200326093831.428337-1-borntraeger@de.ibm.com>
        <20200326094241.GA996751@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032610-0012-0000-0000-0000039865B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032610-0013-0000-0000-000021D560D9
Message-Id: <20200326210401.7060e766@kryten.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_01:2020-03-24,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=473 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> On Thu, Mar 26, 2020 at 10:38:31AM +0100, Christian Borntraeger wrote:
> > Provide IBM contact for embargoed hardware issues. As POWER and Z
> > are different teams with different designs it makes sense to have
> > separate persons for the first contact.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Anton Blanchard <anton@linux.ibm.com>
> > ---
> >  Documentation/process/embargoed-hardware-issues.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/embargoed-hardware-issues.rst
> > b/Documentation/process/embargoed-hardware-issues.rst index
> > a19d084f9b2c..43cdc67e4f8e 100644 ---
> > a/Documentation/process/embargoed-hardware-issues.rst +++
> > b/Documentation/process/embargoed-hardware-issues.rst @@ -246,7
> > +246,8 @@ an involved disclosed party. The current ambassadors
> > list: =============
> > ======================================================== ARM
> >    Grant Likely <grant.likely@arm.com> AMD		Tom
> > Lendacky <tom.lendacky@amd.com>
> > -  IBM
> > +  IBM Z         Christian Borntraeger <borntraeger@de.ibm.com>
> > +  IBM Power     Anton Blanchard <anton@linux.ibm.com>  
> 
> Can I get an ack from Anton that he really agrees with this?  :)

Sure :)

Acked-by: Anton Blanchard <anton@linux.ibm.com>

Thanks,
Anton


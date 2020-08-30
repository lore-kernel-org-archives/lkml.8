Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0464207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tYJF8x20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgH3J5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:57:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51096 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgH3J5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:57:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07U9XtR3001438;
        Sun, 30 Aug 2020 05:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zZZaGO9f6qJS5ucPnn8G8zA+KB54agYzgvVLkqVDWi8=;
 b=tYJF8x208ofzu7GOhWPgHPcswnpNR+x7iLNKufVbymAkVQJbr0Z1szfJSS9rZGSbrdlI
 I5XCpB+445wILSWhjn0RPv8AK2byOfb7CoJr7rl4eQ/Jt1AUVIUytGlTCgKkeaAiU491
 FZ4VLlD8o54+ncSgWFCPMXAoS6f2pSXQjObOcYzishkRxchsNGZLHck34WXXfOqgfmnX
 4q0JHvFMchFLuZaSiECBaqnBI9y2QbNSUeBpl/vq0k792c9Avm40lEmJK1+zxKUQiidj
 FaQV3owHbWG6duCGlpUg+k249urRc5meKenePZ50ei8fQDoe/LbVMXV2fhJKZdeWnc9E Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3388n6h7x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 05:56:56 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07U9ZwbG005193;
        Sun, 30 Aug 2020 05:56:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3388n6h7wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 05:56:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07U9lXWo018395;
        Sun, 30 Aug 2020 09:56:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 337en891xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 09:56:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07U9upSu25035050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 09:56:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D177652051;
        Sun, 30 Aug 2020 09:56:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.92.75])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 65C4352050;
        Sun, 30 Aug 2020 09:56:50 +0000 (GMT)
Date:   Sun, 30 Aug 2020 12:56:48 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [ALTERNATE PATCH] memblock: fix min_low_pfn/max_low_pfn build
 errors
Message-ID: <20200830095648.GA424181@linux.ibm.com>
References: <20200829000139.2513-1-rdunlap@infradead.org>
 <20200829130429.GG167163@linux.ibm.com>
 <a0665bb7-3389-1178-0a79-2155fb88255d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0665bb7-3389-1178-0a79-2155fb88255d@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-30_03:2020-08-28,2020-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=1 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=927
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sat, Aug 29, 2020 at 08:40:51AM -0700, Randy Dunlap wrote:
> On 8/29/20 6:04 AM, Mike Rapoport wrote:
> > On Fri, Aug 28, 2020 at 05:01:39PM -0700, Randy Dunlap wrote:
> >> Export min_low_pfn & max_low_pfn in mm/memblock.c to fix build errors
> >> on arch/microblaze/ and arch/ia64/: (e.g.)
> > 
> > Please don't. This would give driver developers a wrong impression that
> > these variables can be used to query memory boundaries, but this is not
> > the case, at least not on all architectures.
> > 
> > I would prefer fixing it up locally for microblaze and ia64.
> 
> I did that.
> and that's why this is labeled as an ALTERNATE PATCH.

I've seen that, I just wanted to make sure that Andrew wouldn't pick
this one :)

I can help with taking microblaze and ia64 patches via memblock tree
once we have Acks from the arch maintainers.
 
> thanks.
> -- 
> ~Randy
> 

-- 
Sincerely yours,
Mike.

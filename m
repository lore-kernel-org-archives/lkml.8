Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C53C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A849207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IqO/TChs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbgE0Oo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:44:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388395AbgE0Oo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:44:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04REWIfV075768;
        Wed, 27 May 2020 10:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7waPXxmqOb2JTYV7nWQNNzi61qxyRAO+Tex4ihurDw8=;
 b=IqO/TChsc12Na6cXRGTpRTREGCUkvT+ZI8cVpoQ4wFlWOFxKtT8OKpz8Jsc6tj9OUIyu
 CeX2BXzPHM08a2pPaHhdlxE9kEAQolM7r1VrpjikO4yFFz9+Sl/q4apSH77zdp5LasCn
 KSsJDpxRHGVC20KKS61UVjHqR3YgH7lR1ltLxFKJWispN2P5bfdJIoeNPb5nq6n0m5IW
 C2R0CrcbSGHSt/ilnN4UccdKInkoHOjqcOmKFMLcaRO9G0lv8ceFs0bmFVsqdN7/SviN
 L6zXncvOVf8P1iBM8Kj2gZFdkkUCAZiQAJJYPbf9Z9YRyNa6eryKt7hYdB3j/JHRFqlD Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319s3bjvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 10:43:57 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04REWMBa076215;
        Wed, 27 May 2020 10:43:57 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319s3bjvu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 10:43:57 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04REfYgZ014368;
        Wed, 27 May 2020 14:43:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 316uf8ka69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 14:43:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04REhrnh62390746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 14:43:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01FC8AE056;
        Wed, 27 May 2020 14:43:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 150D7AE053;
        Wed, 27 May 2020 14:43:51 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.113.138])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 May 2020 14:43:50 +0000 (GMT)
Subject: Re: [PATCH 2/3] objtool: Move struct objtool_file into
 arch-independent header
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <8a877bc283cbad704c7472ac3ef534d49629dd05.1589913349.git.mhelsley@vmware.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <ddafdbee-edba-8082-74f2-ec3da9156cf3@linux.vnet.ibm.com>
Date:   Wed, 27 May 2020 20:13:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8a877bc283cbad704c7472ac3ef534d49629dd05.1589913349.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 2:25 AM, Matt Helsley wrote:
> The objtool_file structure describes the files objtool works on,
> is used by the check subcommand, and the check.h header is included
> by the orc subcommands so it's presently used by all subcommands.
> 
> Since the structure will be useful in all subcommands besides check,
> and some subcommands may not want to include check.h to get the
> definition, split the structure out into a new header meant for use
> by all objtool subcommands.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh

Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D4B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nL7WdIeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbgE0Oot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:44:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388356AbgE0Oot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:44:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04REYBvK021658;
        Wed, 27 May 2020 10:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QcsehmUTswszS2C6wXzSJQ3zyE4B6tGLooj2htY2/tw=;
 b=nL7WdIeL/Svz5IWVh8JOVmtR70/1ExLjt4teN4GK97jPBm57zaQ84D6TBW8K/fdLJKUz
 lopq4znCi1i3mhYAGvhLdp9GhDhbVQdJf+Vx1X/W4k+VTzJxXabcbb0acXMl3KVoV1f8
 +v6xBTnHK/CxvfwDs+e9vDGtDeVnEosTihy+12NuXG8e9TkcUBUIM66B+thp+bq90jk8
 se56LPzqHUXPKX+Ud3b8ToXe1KH0FBt9JFOY8TFunsd3y8Qe0KU2fkX51OfIU6JSBbMv
 yDsbGp4drAe26kIZX/+0Jw5khYL1p3QnPfIy/769MsIL83oXUAc5bD8eFrp40B7vE97v hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319qvwdj8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 10:44:28 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04REYFOV021912;
        Wed, 27 May 2020 10:44:27 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319qvwdj7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 10:44:27 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04REfYgc014368;
        Wed, 27 May 2020 14:44:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 316uf8ka6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 14:44:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04REiNnu62390434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 14:44:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95E1BAE055;
        Wed, 27 May 2020 14:44:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C57AE053;
        Wed, 27 May 2020 14:44:22 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.113.138])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 27 May 2020 14:44:21 +0000 (GMT)
Subject: Re: [PATCH 1/3] objtool: Exit successfully when requesting help
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <26346796590ccf07ffe7b9d2b230435c9e787357.1589913349.git.mhelsley@vmware.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <a9c1387b-a95f-24c9-982f-0d969f0da624@linux.vnet.ibm.com>
Date:   Wed, 27 May 2020 20:14:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <26346796590ccf07ffe7b9d2b230435c9e787357.1589913349.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 2:25 AM, Matt Helsley wrote:
> When the user requests help it's not an error so do not exit with
> a non-zero exit code. This is not especially useful for a user but
> any script that might wish to check that objtool --help is at least
> available can't rely on the exit code to crudely check that, for
> example, building an objtool executable succeeds.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh

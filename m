Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58DC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 00:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8DD20678
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 00:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgDFAbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 20:31:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbgDFAbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 20:31:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0360VQND059556
        for <linux-kernel@vger.kernel.org>; Sun, 5 Apr 2020 20:31:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306p7sjpr1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 20:31:47 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ajd@linux.ibm.com>;
        Mon, 6 Apr 2020 01:31:24 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Apr 2020 01:31:22 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0360VhAR46727478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 00:31:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43B68A4053;
        Mon,  6 Apr 2020 00:31:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E48AAA4040;
        Mon,  6 Apr 2020 00:31:42 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Apr 2020 00:31:42 +0000 (GMT)
Received: from [9.206.138.204] (unknown [9.206.138.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 14BAEA021B;
        Mon,  6 Apr 2020 10:31:37 +1000 (AEST)
Subject: Re: [PATCH] Fix: buffer overflow during hvc_alloc().
To:     andrew@daynix.com, virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com
References: <20200405204024.1007843-1-andrew@daynix.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Date:   Mon, 6 Apr 2020 10:31:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405204024.1007843-1-andrew@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20040600-0016-0000-0000-000002FF0476
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040600-0017-0000-0000-00003362D8BC
Message-Id: <a8ab8fe3-3200-9591-7572-abbbd2d505ff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-05_11:2020-04-03,2020-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 6:40 am, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
> 
> If there is a lot(more then 16) of virtio-console devices
> or virtio_console module is reloaded
> - buffers 'vtermnos' and 'cons_ops' are overflowed.
> In older kernels it overruns spinlock which leads to kernel freezing:
> https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> 

This Bugzilla report isn't publicly accessible. Can you include a 
relevant summary here and/or make the report publicly viewable?

If it does indeed lead to a kernel freeze, this should be tagged with a 
Fixes: and a Cc: stable@vger.kernel.org.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited


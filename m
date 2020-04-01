Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E118D20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgDAJqH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:46:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730420AbgDAJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:46:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0319X4WW087857
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 05:46:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304edwqnnm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 05:46:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 1 Apr 2020 10:45:48 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 10:45:46 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0319k0Xi52560032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 09:46:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB6EF42047;
        Wed,  1 Apr 2020 09:46:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6459B4204D;
        Wed,  1 Apr 2020 09:46:00 +0000 (GMT)
Received: from localhost (unknown [9.85.74.146])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 09:46:00 +0000 (GMT)
Date:   Wed, 01 Apr 2020 15:15:57 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 5/6] Documentation: Document sysfs interfaces purr,
 spurr, idle_purr, idle_spurr
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
        <1585308760-28792-6-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1585308760-28792-6-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20040109-0020-0000-0000-000003BF84A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040109-0021-0000-0000-0000221829A3
Message-Id: <1585734290.ovukp60xf0.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Add documentation for the following sysfs interfaces:
> /sys/devices/system/cpu/cpuX/purr
> /sys/devices/system/cpu/cpuX/spurr
> /sys/devices/system/cpu/cpuX/idle_purr
> /sys/devices/system/cpu/cpuX/idle_spurr
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 2e0e3b4..bc07677 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -580,3 +580,42 @@ Description:	Secure Virtual Machine
>  		If 1, it means the system is using the Protected Execution
>  		Facility in POWER9 and newer processors. i.e., it is a Secure
>  		Virtual Machine.
> +
> +What: 		/sys/devices/system/cpu/cpuX/purr
> +Date:		Apr 2005
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	PURR ticks for this CPU since the system boot.
> +
> +		The Processor Utilization Resources Register (PURR) is
> +		a 64-bit counter which provides an estimate of the
> +		resources used by the CPU thread. The contents of this
> +		register increases monotonically. This sysfs interface
> +		exposes the number of PURR ticks for cpuX.
> +
> +What: 		/sys/devices/system/cpu/cpuX/spurr
> +Date:		Dec 2006
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	SPURR ticks for this CPU since the system boot.
> +
> +		The Scaled Processor Utilization Resources Register
> +		(SPURR) is a 64-bit counter that provides a frequency
> +		invariant estimate of the resources used by the CPU
> +		thread. The contents of this register increases
> +		monotonically. This sysfs interface exposes the number
> +		of SPURR ticks for cpuX.
> +
> +What: 		/sys/devices/system/cpu/cpuX/idle_purr
> +Date:		Mar 2020
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	PURR ticks for cpuX when it was idle.
> +
> +		This sysfs interface exposes the number of PURR ticks
> +		for cpuX when it was idle.
> +
> +What: 		/sys/devices/system/cpu/cpuX/idle_spurr
> +Date:		Mar 2020
> +Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
> +Description:	SPURR ticks for cpuX when it was idle.
> +
> +		This sysfs interface exposes the number of SPURR ticks
> +		for cpuX when it was idle.

Apart from the minor comment on patches 2 and 3, from the sysfs 
interface standpoint, for patches 1 to 5:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen


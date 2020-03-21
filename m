Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955BC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EC22070A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCUAsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:48:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbgCUAsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:48:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L0aMTV134763
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 20:48:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7furs4h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 20:48:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Sat, 21 Mar 2020 00:48:00 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 21 Mar 2020 00:47:57 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02L0ltuj39911824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Mar 2020 00:47:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C38FB11C04C;
        Sat, 21 Mar 2020 00:47:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AC0F11C04A;
        Sat, 21 Mar 2020 00:47:54 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.223.94])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 21 Mar 2020 00:47:54 +0000 (GMT)
Date:   Fri, 20 Mar 2020 17:47:51 -0700
From:   Ram Pai <linuxram@us.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20200320102643.15516-1-ldufour@linux.ibm.com>
 <20200320102643.15516-3-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320102643.15516-3-ldufour@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 20032100-4275-0000-0000-000003B005B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032100-4276-0000-0000-000038C53882
Message-Id: <20200321004751.GB5243@oc0525413822.ibm.com>
Subject: Re:  [PATCH 2/2] KVM: PPC: Book3S HV: H_SVM_INIT_START must call UV_RETURN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_08:2020-03-20,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=868 suspectscore=2 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:26:43AM +0100, Laurent Dufour wrote:
> When the call to UV_REGISTER_MEM_SLOT is failing, for instance because
> there is not enough free secured memory, the Hypervisor (HV) has to call
			   secure memory,

> UV_RETURN to report the error to the Ultravisor (UV). Then the UV will call
> H_SVM_INIT_ABORT to abort the securing phase and go back to the calling VM.
> 
> If the kvm->arch.secure_guest is not set, in the return path rfid is called
> but there is no valid context to get back to the SVM since the Hcall has
> been routed by the Ultravisor.
> 
> Move the setting of kvm->arch.secure_guest earlier in
> kvmppc_h_svm_init_start() so in the return path, UV_RETURN will be called
> instead of rfid.
> 
> Cc: Bharata B Rao <bharata@linux.ibm.com>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Ram Pai <linuxram@us.ibm.com>


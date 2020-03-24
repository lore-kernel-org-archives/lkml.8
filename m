Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E406206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgCXNpH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:45:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727393AbgCXNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:45:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ODXvC8027797
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:45:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuvedc1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:45:05 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 24 Mar 2020 13:45:01 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 13:44:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ODhvUv26870248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 13:43:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0F2FA405B;
        Tue, 24 Mar 2020 13:44:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DE06A405C;
        Tue, 24 Mar 2020 13:44:59 +0000 (GMT)
Received: from localhost (unknown [9.85.116.99])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 13:44:59 +0000 (GMT)
Date:   Tue, 24 Mar 2020 19:14:53 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf dso: Fix dso comparison
To:     acme@kernel.org, jolsa@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org
References: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200324042424.68366-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20032413-0008-0000-0000-0000036306BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032413-0009-0000-0000-00004A8472F9
Message-Id: <1585057428.a1bcmu1ynn.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria wrote:
> Perf gets dso details from two different sources. 1st, from builid
> headers in perf.data and 2nd from MMAP2 samples. Dso from buildid
> header does not have dso_id detail. And dso from MMAP2 samples does
> not have buildid information. If detail of the same dso is present
> at both the places, filename is common.
> 
> Previously, __dsos__findnew_link_by_longname_id() used to compare only
> long or short names, but Commit 0e3149f86b99 ("perf dso: Move dso_id
> from 'struct map' to 'struct dso'") also added a dso_id comparison.
> Because of that, now perf is creating two different dso objects of the
> same file, one from buildid header (with dso_id but without buildid)
> and second from MMAP2 sample (with buildid but without dso_id).
> 
> This is causing issues with archive, buildid-list etc subcommands. Fix
> this by comparing dso_id only when it's present. And incase dso is
> present in 'dsos' list without dso_id, inject dso_id detail as well.
> 
> Before:
> 
>   $ sudo ./perf buildid-list -H
>   0000000000000000000000000000000000000000 /usr/bin/ls
>   0000000000000000000000000000000000000000 /usr/lib64/ld-2.30.so
>   0000000000000000000000000000000000000000 /usr/lib64/libc-2.30.so
> 
>   $ ./perf archive
>   perf archive: no build-ids found
> 
> After:
> 
>   $ ./perf buildid-list -H
>   b6b1291d0cead046ed0fa5734037fa87a579adee /usr/bin/ls
>   641f0c90cfa15779352f12c0ec3c7a2b2b6f41e8 /usr/lib64/ld-2.30.so
>   675ace3ca07a0b863df01f461a7b0984c65c8b37 /usr/lib64/libc-2.30.so
> 
>   $ ./perf archive
>   Now please run:
> 
>   $ tar xvf perf.data.tar.bz2 -C ~/.debug
> 
>   wherever you need to run 'perf report' on.
> 
> Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Fixes: 0e3149f86b99 ("perf dso: Move dso_id from 'struct map' to 'struct dso'")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/dsos.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Thanks. This fixes the issue I was facing with 'perf archive' not 
picking up the right binaries.  So:
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen


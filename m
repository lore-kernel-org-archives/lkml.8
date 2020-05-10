Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A607EC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899F92082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgEJNEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 09:04:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728743AbgEJNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 09:04:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04AD3U1E196506;
        Sun, 10 May 2020 09:03:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws9xhe4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 09:03:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04AD0n5s008056;
        Sun, 10 May 2020 13:03:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30wm55jfrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 13:03:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04AD36ZQ52559932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 13:03:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E187142042;
        Sun, 10 May 2020 13:03:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF8F142045;
        Sun, 10 May 2020 13:03:03 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.51.177])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sun, 10 May 2020 13:03:03 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sun, 10 May 2020 18:33:02 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external modules
In-Reply-To: <20200508160935.GB19436@zn.tnic>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com> <20200508104922.72565-3-vaibhav@linux.ibm.com> <20200508113100.GA19436@zn.tnic> <87blmy8wm8.fsf@linux.ibm.com> <20200508160935.GB19436@zn.tnic>
Date:   Sun, 10 May 2020 18:33:02 +0530
Message-ID: <87v9l46iyh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_05:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=979 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Borislav Petkov <bp@alien8.de> writes:

> On Fri, May 08, 2020 at 05:30:31PM +0530, Vaibhav Jain wrote:
>> I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
>> here.
>
> And what does "external" refer to? Because if it is out-of-tree, we
> don't export symbols for out-of-tree modules.
>
> Looks like you're exporting it for that papr_scm.c thing, which is fine.
> But that is not "external".
>
> So?

I should have used the term 'non-builtin' or 'kernel loadable' modules rather than
external modules in this patch description. Apologies for the confusion it caused.

~ Vaibhav
>
> -- 
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86141C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D0E214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BcTXvoSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgBDXhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:37:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51668 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgBDXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:37:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014NXSju080207;
        Tue, 4 Feb 2020 23:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2019-08-05;
 bh=c89x4AYik3CY1dqU0wAVrxhhMg8pCILWGeQVUweuj80=;
 b=BcTXvoSgSVY0m9Zzdg/u2oQVSbOgPMijyGuj5/cPHMH6Wq2/zuOk5s0RrK1cL4vs3yYn
 +/090kIgsQcfCSdXLEAaJHXHlnZfYAbAZxeZqAKkO3sHqD08O2IMIgFKXBE6RayLRd7B
 gHdhmQCa11ujg63Mf5NH/OLsT6jCDMBY6U8w3KVoCrgsCqE94Xc7ciGudP60fbEanmnv
 xTRsaVl/ZVuhbMIFU6ByYia5a0dwZ8KyuPURF9PDVeGYhqHFE1hDFBBpymD0XhJeeJ59
 0uiNq5Fm98VmSMb9T7VY5oi3IAU/39pY63LAt3W7l1xZaCVMvIqWmWtLYGBB5xTMlkbf Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xyhkfg614-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 23:37:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014NXQKX177891;
        Tue, 4 Feb 2020 23:37:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xyhmqubup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 23:37:34 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014NbWoi010973;
        Tue, 4 Feb 2020 23:37:32 GMT
Received: from dhcp-10-154-157-166.vpn.oracle.com (/10.154.157.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 15:37:32 -0800
Message-ID: <787a40adec270a7c72ab1862f4fe1ada088818f1.camel@oracle.com>
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 04 Feb 2020 16:37:30 -0700
In-Reply-To: <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
         <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
         <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2001150001 definitions=main-2002040160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-2001150001
 definitions=main-2002040160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-04 at 13:42 -0800, Mike Kravetz wrote:
> On 2/4/20 12:33 PM, David Rientjes wrote:
> > 
> > So it looks like this is fixing an obvious correctness issue but
> > also now 
> > requires users to rewrite the sysctl if they want to decrease the
> > min 
> > watermark.
> 
> Moving the call to khugepaged_adjust_min_free_kbytes as described
> above
> would avoid the THP adjustment unless we were going to overwrite the
> user defined value.  Now, I am not sure overwriting the user defined
> value
> as is done today is actually the correct thing to do.
> 
> Thoughts?
> Perhaps we should never overwrite a user defined value?

We might need to override user defined value if it is too low but
overriding it silently is not quite right. We should print a warning
at least. On the other hand, a user setting min_free_kbytes should know
what they are doing and if they set it too low, they have been warned
in the sysctl documentation. I would say we never override user defined
value but print a warning if the value is too low and kernel would have
adjusted it if it were not for the user defined value.

--
Khalid


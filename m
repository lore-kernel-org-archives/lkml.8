Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEBFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99182086A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgGXAHJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:07:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727778AbgGXAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:07:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O02cfu031283;
        Thu, 23 Jul 2020 20:06:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32faj3sn4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 20:06:53 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O03sSB034159;
        Thu, 23 Jul 2020 20:06:53 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32faj3sn44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 20:06:53 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O05XXm030936;
        Fri, 24 Jul 2020 00:06:52 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 32brq9ra27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 00:06:52 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O06nx647055344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 00:06:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCF9478063;
        Fri, 24 Jul 2020 00:06:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 560557805C;
        Fri, 24 Jul 2020 00:06:47 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.53.35])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jul 2020 00:06:46 +0000 (GMT)
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com> <159524954805.20855.1164928096364700614.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 06/12] ppc64/kexec_file: restrict memory usage of kdump kernel
In-reply-to: <159524954805.20855.1164928096364700614.stgit@hbathini.in.ibm.com>
Date:   Thu, 23 Jul 2020 21:06:42 -0300
Message-ID: <875zad6ajx.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=2
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> Kdump kernel, used for capturing the kernel core image, is supposed
> to use only specific memory regions to avoid corrupting the image to
> be captured. The regions are crashkernel range - the memory reserved
> explicitly for kdump kernel, memory used for the tce-table, the OPAL
> region and RTAS region as applicable. Restrict kdump kernel memory
> to use only these regions by setting up usable-memory DT property.
> Also, tell the kdump kernel to run at the loaded address by setting
> the magic word at 0x5c.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>
> ---
>
> v3 -> v4:
> * Updated get_node_path() to be an iterative function instead of a
>   recursive one.
> * Added comment explaining why low memory is added to kdump kernel's
>   usable memory ranges though it doesn't fall in crashkernel region.
> * For correctness, added fdt_add_mem_rsv() for the low memory being
>   added to kdump kernel's usable memory ranges.

Good idea.

> * Fixed prop pointer update in add_usable_mem_property() and changed
>   duple to tuple as suggested by Thiago.

<snip>

> +/**
> + * get_node_pathlen - Get the full path length of the given node.
> + * @dn:               Node.
> + *
> + * Also, counts '/' at the end of the path.
> + * For example, /memory@0 will be "/memory@0/\0" => 11 bytes.

Wouldn't this function return 10 in the case of /memory@0?
Are you saying that it should count the \0 at the end too? it's not
doing that, AFAICS.

> + *
> + * Returns the string length of the node's full path.
> + */

Maybe it's me (by analogy with strlen()), but I would expect "string
length" to not include the terminating \0. I suggest renaming the
function to something like get_node_path_size() and do s/length/size/ in
the comment above if it's supposed to count the terminating \0.

> +static int get_node_pathlen(struct device_node *dn)
> +{
> +	int len = 0;
> +
> +	if (!dn)
> +		return 0;
> +
> +	while (dn) {
> +		len += strlen(dn->full_name) + 1;
> +		dn = dn->parent;
> +	}
> +
> +	return len + 1;
> +}
> +
> +/**
> + * get_node_path - Get the full path of the given node.
> + * @node:          Device node.
> + *
> + * Allocates buffer for node path. The caller must free the buffer
> + * after use.
> + *
> + * Returns buffer with path on success, NULL otherwise.
> + */
> +static char *get_node_path(struct device_node *node)
> +{
> +	struct device_node *dn;
> +	int len, idx, nlen;
> +	char *path = NULL;
> +	char end_char;
> +
> +	if (!node)
> +		goto err;
> +
> +	/*
> +	 * Get the path length first and use it to iteratively build the path
> +	 * from node to root.
> +	 */
> +	len = get_node_pathlen(node);
> +
> +	/* Allocate memory for node path */
> +	path = kzalloc(ALIGN(len, 8), GFP_KERNEL);
> +	if (!path)
> +		goto err;
> +
> +	/*
> +	 * Iteratively update path from node to root by decrementing
> +	 * index appropriately.
> +	 *
> +	 * Also, add %NUL at the end of node & '/' at the end of all its
> +	 * parent nodes.
> +	 */
> +	dn = node;
> +	path[0] = '/';
> +	idx = len - 1;

Here, idx is pointing to the supposed '/' at the end of the node
path ...

> +	end_char = '\0';
> +	while (dn->parent) {
> +		path[--idx] = end_char;

.. and in the first ireation, this is writing '\0' at a place which will be
overwritten by the memcpy() below with the last character of
dn->full_name. You need to start idx with len, not len - 1.

> +		end_char = '/';
> +
> +		nlen = strlen(dn->full_name);
> +		idx -= nlen;
> +		memcpy(path + idx, dn->full_name, nlen);
> +
> +		dn = dn->parent;
> +	}
> +
> +	return path;
> +err:
> +	kfree(path);
> +	return NULL;
> +}

--
Thiago Jung Bauermann
IBM Linux Technology Center

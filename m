Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA9C54FD0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 02:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E6320748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 02:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aF6Q6Etd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RpxJiT6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDYCqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:46:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbgDYCql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 22:46:41 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03P2kZvW014766;
        Fri, 24 Apr 2020 19:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1t6nCeZ91I+ka8nBz++t4jvOhAcG0CxhD2lhON2i19U=;
 b=aF6Q6EtdLGHRl6hZqjo6ZVwj5oCzQ1QOWxfVacSutfNqFzPFj4rUj/gxQfgGqa80CLdP
 UghC3WthLiH0yhTtjJux80w3Cjq32Jb8e4qP1lUmQY2+GLOczFmkCMCmiLl3gJAxyQwn
 5gu4g9N8nbr2B5uwp5DDoIvRZnL6aMxal5s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30keb1are2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 19:46:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 24 Apr 2020 19:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0lM9QUTdcmhT0nbvCivPpRzwbT6/5rGmGKWdJtC+cr/N2ZiXEeo936Z1vscieCMmocUhPG9IvZ4YTN2gljt1yZQqbOxOatS24C+3hItt53cPXr6F+7PekNDA/EeL4WVqV/YEjdJvDpJFsVuuC8fPH1E362ToTDDuPtFkYDsHbl2hf38aPuVSCqR4h1VhOSMmT7DrV0VV0ZDlwk5ItW2KYPGe6EAQjUZC52WJRvW1CeZ2hkx3X6nRsASTNn+/F5zlrDLjmk3EzS4ATLBL82h0CQGd6JVwVeQa/0Bb64SKAVdhfZ1NV0UpPJgVcLZKPE/ZnS3tKl2g+bC1AlE4HXphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t6nCeZ91I+ka8nBz++t4jvOhAcG0CxhD2lhON2i19U=;
 b=b5DZCHCCxkjC8marpHdXYVp+osyQCR8wK3HgxVBrk6CRTZfchGzfA4X5fVYEBVzZa59NBksdetNyREx8sdH9cqcdcbrVJWB971+QwtYmJqxVTUMbQGSWYLqFktjwor13A6qIsuD44kH6ctdCAquNe54M4PhhPhKozYm6GTX1QLM1xc54e/4i2MeSI1uqMgjBSJZSiwKlCyFUmQm9ktgA2Wk7RFLvDqjzys25zoGMo3FehFeWqraR6yO58rHDsoSMdPmhwgeA9hyfjuAv7X7jCN6nOtkvxQSI4biiqC+ea3hF9V5yRQf8RHfQq3NgvS/WbGgx862UGsnOKjZHWIfBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t6nCeZ91I+ka8nBz++t4jvOhAcG0CxhD2lhON2i19U=;
 b=RpxJiT6osye1L4KUTA38MU8ac0ZpqzbEorbtlx0q7KuJei0pNYCwBfPYjtcz3ReWvVCLWo3Fl3A86noBr5fyIyf8NCMrgzu2+5twzgvvJYJrWey2yeWdFqehkSPGH5Eb1j8j6W0NL1eY+4Bl6lMeOz+HYhkUDguhJySo/huUvOw=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3079.namprd15.prod.outlook.com (2603:10b6:a03:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 25 Apr
 2020 02:46:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.012; Sat, 25 Apr 2020
 02:46:30 +0000
Date:   Fri, 24 Apr 2020 19:46:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200425024625.GA107755@carbon.lan>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
 <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
X-ClientProxiedBy: MWHPR21CA0067.namprd21.prod.outlook.com
 (2603:10b6:300:db::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:1973) by MWHPR21CA0067.namprd21.prod.outlook.com (2603:10b6:300:db::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.10 via Frontend Transport; Sat, 25 Apr 2020 02:46:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:1973]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b14eef9-eaaf-4779-c3b0-08d7e8c2db5c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3079AA9A4A5DB984FCF45213BED10@BYAPR15MB3079.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(66946007)(16526019)(66476007)(316002)(186003)(86362001)(6506007)(66556008)(9686003)(54906003)(8936002)(36756003)(8676002)(81156014)(55016002)(33656002)(7696005)(52116002)(6916009)(8886007)(4326008)(478600001)(5660300002)(2906002)(6666004)(966005)(1076003)(27376004);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jqij9YZLsTUxkuy0aICXD9Xias29GtRVkKYXym0Mzsyzdjjp1fY7WkciPuE7aWhyGXreys6uhEmCyBt0IBAWitQGFryJ9Jqg9mUjzUqnwW6XWJDtayO9zCdmNOwV6aNnXj3GPNTnrvYFeh11OvANCUkwh9yzNePht0Xg9iCf7wge74LO0KEzkAb96ROUfF/7Y0iDLB9BmWmHlDGnO/CHKRYT5kVGp52NOk+GcZzRdzbe+dHaylF85sFGTF55mquIrLyINbXhCS5kVSCJvnVIXr9BSnlrYvpZGY/en0fxiqz105cG4vG8uqQa01fn7Xv1LPqxvB2jayefjnL+yJbhrfTI+ekt8g05l/qYyhhbg68G40xo4DPntDn/qxo7GsI0b+HkhUUvyjrNFXShfrc+aWNozkSII3XbNDMy6bQ2X0Rea9UyZ+xQ2TE/8YXTsZzRQdGs8LmBXWyY/Yvb0fOJt+ihTJnVY2Vdsv5Yddpqypenoa7eGeyIhR2SI+gKQSV/3ocsjpd/YIkAOBQ72raDqmsr3H2I0GnPXuazj3MERIZStncAOUOLxKsoJEcn4m0i
X-MS-Exchange-AntiSpam-MessageData: nNmmm2CP08QQFROglcvBElpPmwzlmW1JE6JlOt7xps//fFluDffRacPVJu4YZwqXI5Gnmp5YtnSUfx8I1KpMBx+6cFvFTWc/OeKPGojbcgnjYtXb+++oFuVa1D3UVL+D3CpJe3vmIK7/7wrrq3bJXVXAmYPj2TipL+hDr+P6i47UuQXgsYg3l1O7nsbO9TYDlvJGYu5By2Y9BScOrtfTI/ZKJhzYdKwj0BM6cR1mx7jV4+sbDE01DxwvIzLrQmsOfEayGy3Zm7fT9/lMyLAtxGb6mG8pg/GkYe7xsKxlf4C4xhxT/puml4oVHUAA4HPSbrjSlUWeMAaT0PLA8n7gSlqAHVw7OTFEB/EE/nffdPVdDAr9r4wCrO6aW9dHRui9ko2FlMqefMAnpRHIFwoDNNGgFxM91biECiMSBCbRWPC/lRP+K5NAJvKzYlYDDrTFHgdrssMLTszqj6+YyPtrJY1OFDGVwM6PY+syzhH18J7d0P0qPby0k0hx2BRCs7SOugQaci6yt68ArnWyFM4Zl/1CtTuqyG50RMNi8+cULrdflbvXxmKqNdz45xhvDE2HorQapLdUw01Nkz/a92+jO5op1a79qvAzP+JxMlmRiuUIoq7juf6/nz8agusOg0tnHpiPK59MzKs2Njt/0f1WqZnYzNk4MS0lob3LclaUCKPqrl7tLEIuCcB1Lnt/HhRD429aye5h1s6TC1DK9/uw6fU+n8vi1tMX7vEUWfzJZ2zzqwas/tzhKs7OD5VucYxQomE76sp69u6P4Hq7OrQfD5UaP82zDHt4A8jXW5VMghv4JidvnXQwVyMoq/rMObO7NK3wNTOSCDcaRpo+qxxrrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b14eef9-eaaf-4779-c3b0-08d7e8c2db5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 02:46:29.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uka+CPf5u/Ew5cCwTEGNZU07vwb4hIr9uap34NfBidY42Ewl4n5qG1xCxz+JVwzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3079
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_13:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004250022
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 02:10:24AM +0000, Christoph Lameter wrote:
> On Wed, 22 Apr 2020, Roman Gushchin wrote:
> 
> > On Wed, Apr 22, 2020 at 11:52:13PM +0000, Christoph Lameter wrote:
> > > On Wed, 22 Apr 2020, Roman Gushchin wrote:
> > >
> > > >  enum stat_item {
> > > >  	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> > > > @@ -86,6 +87,7 @@ struct kmem_cache {
> > > >  	unsigned long min_partial;
> > > >  	unsigned int size;	/* The size of an object including metadata */
> > > >  	unsigned int object_size;/* The size of an object without metadata */
> > > > +	struct reciprocal_value reciprocal_size;
> > >
> > >
> > > This needs to be moved further back since it is not an item that needs to
> > > be cache hot for the hotpaths.
> >
> > It could be relatively hot, because it's accessed for reading on every
> > accounted allocation.
> 
> The patch seems to only use it for setup and debugging? It is used for
> every "accounted" allocation???? Where? And what is an "accounted"
> allocation?
> 
>

Please, take a look at the whole series:
https://lore.kernel.org/linux-mm/20200422204708.2176080-1-guro@fb.com/T/#t

I'm sorry, I had to cc you directly for the whole thing. Your feedback
will be highly appreciated.

It's used to calculate the offset of the memcg pointer for every slab
object which is charged to a memory cgroup. So it must be quite hot.

Thanks!

Roman

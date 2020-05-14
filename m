Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121ECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7AE2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jPn50uVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgENUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:06:39 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:51264
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbgENUGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:06:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M39JKO+9DKG3owqAaUQZ5qdBhQLB3ArcKZGQeFCKVoCTL5tSk50673SXqxulr15Sfvnc/KrawnvEu+kuzMo7qpHryuM3xoArjAFQFfJLUjbPphaNroBkvDGXXJ8rwC7yhrSdoHKekp12MP3q+pJdliXYVlvUxErClY+WvPkncwa9XHuNJVhgGDA+3Aad0eOljzSJYTh4NIVLG30lNSAW4GkAIjd3qiOPBSd9tV3zRFSzeV+GzVxmyWK2tAnBaJG+faq6gZd+uht9CwVZAV38O9f0sKzIBvu82lKU/jYOBJJ643wVVhii+894q2yD+0rgjthmrq7bC+IFsaZcLrKqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHN546ZP9MPGPBPjQW43l+vSD7fqzGSsGSTQ+Mkc4ro=;
 b=LRDveYI+tX88+q4UmsCpI4QOrPto+xCTyXJ/FBBc1Lw9z1ogjRcfxgFYVgvK+CdGGdLplyJ32ARQ+YBdnl/ZPcXtLhw6+NT2Dp+7l0biTBsyXDLKgh+4Qd58+JFgL0WHQuzn2GlFXd7xQWJBRORLFJEh0YjV8BIjEC+eaEW0+NrVvnkA9aCCSNAcNMV9LcCR7gsajKcM8kEtJMrg3g4YHXlZ68O5qifxLR6uJn8mDAdnQ79KTx4YjysDzWv0cESN+rPkLu2ZidvVyguWHap2j1zBsUf0Wk1Iv5785KwyYrgicF0Bs/fnR0T+iqZc9TxWwtUfrtCnOfOXs6ItWjD8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHN546ZP9MPGPBPjQW43l+vSD7fqzGSsGSTQ+Mkc4ro=;
 b=jPn50uVLPwCXwUV9o4O/5yas3hTxYqLvHyQ2XRuAwnKrr4iw55YqxeC/cf7up7DWc8ocORkaBFP08t3CtbpGO5+gOgEPzXy3RMisgynGuRPJ2TF1oBJBOr964nS9P9RT0Icn1+HvNp3B+9eAgDp/hui9rCC6JuHDtZoJSc3zDOI=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 20:06:34 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:06:34 +0000
Subject: RE: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <a99e4de3dc3f0e60281de1274ccb064071200fd9.1588808538.git.reinette.chatre@intel.com>
 <9c7a011c-2946-102c-5cdd-9dc5155533ec@amd.com>
 <CAHp75VfSERa3W3u-yAYUVdx3U7FDMwzQFBL4utmYvqKWa-1w_A@mail.gmail.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <662992f6-718b-f26e-36fc-f225241608fb@amd.com>
Date:   Thu, 14 May 2020 15:06:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAHp75VfSERa3W3u-yAYUVdx3U7FDMwzQFBL4utmYvqKWa-1w_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0085.namprd12.prod.outlook.com
 (2603:10b6:802:21::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN1PR12CA0085.namprd12.prod.outlook.com (2603:10b6:802:21::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 20:06:33 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f5a66ee-33bb-401e-de73-08d7f8424d42
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2544F33DF5056C1542E0F64995BC0@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRQaatlQqB+aezCNu74wqIa33d/u1/+haYTqIqVtaKO4K0bZjdGN6a8VZZGztl9Aeg2RwxWaxqg/vn25iwzYGNeN/GdqSLeT8uIPfVvM9zoTIkDbSkxVGpnriaaIrtTgNu4igjdPd1twPosvg6eEBUQTFShAFbqAzOq6tolLGDeyJPAOEvaEA5xmaNVRyGeBYHuEo2xH0hpsjZYsJj/sqZHH4slkaMv5cbc8k932p9uzLH1HxjK0b/OC3MYgWXK+V3DWUX2gZt4C7HEZZNA9zzEcHmAMNagPMg7XMBSbF9ULZQ6uGHJMIAI6RzXjcLegchHlzpU1g7kJwobzj2nXJ9zG4BsXgoVqE2rz5dinNVnf/45tRZ9EBvXx+19xsHB+AQH0Rehx0LtBo86l2XqLQu84G/GNYOq+LRis2qgCBsj6ELnukF4/COcOyNnnKUcucTNe7yUczCH1PQI8KWBsTmBKUEOads14VP9LKZzdrKdAWiAhschdr/SsEih9M9uT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(52116002)(478600001)(31696002)(2906002)(8936002)(7416002)(6916009)(53546011)(44832011)(16526019)(31686004)(5660300002)(54906003)(86362001)(66556008)(316002)(26005)(6486002)(36756003)(4326008)(16576012)(8676002)(186003)(66946007)(66476007)(2616005)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XY6QlF/uwXY51WaW0EILKbyApOE5wPNDeW8f2KP9vRaOa808nHSsAsnPwr5igmv/z5xXiKclNFd3EytlIp0SjOjL/6l8mO3GLp+6iJW7VeAhsaVgIHJj+HcDiyGalJeGxDNkvt7sKpSlpHM0cFGE91ZxvNQXQCtbNE3uu2xiHP1LaLSEdnSOYy4nzp59OMGM8OjwdfIFEAl846tCXUpf6DCsjj/25j+VJbs8otISjP5EFjXLhA2FjcYLdT2/+NppaAWPVK7xDL5BZnx9TKS0+rAiPh3ks8QcYvN2o+95rZVfXTCadJspC5SNoHEq6hJy5+ZBHXaY1t840iZ5KxDIuz30qVBJwAkpB8wG5UCOpg9s3PZ9tfr2v+CmqcfdEXKYvQYAaTJDDe0D71ht8H2NOSboErATDB+F9Y7gYZxJAhl9YDfYJy171f0jIjdL6rzi4B+Ak7rYiym7ChyAs3/1PMLaK21rLcHkxE/Elv0KUQk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5a66ee-33bb-401e-de73-08d7f8424d42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:06:34.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1Xhb5Gbk2J760XUPPQmFKlDSOmMIYX7+Voto/L75jUjlkeYPwlRhZjtPh62TjKv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Sent: Thursday, May 14, 2020 2:11 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>; tglx@linutronix.de;
> fenghua.yu@intel.com; bp@alien8.de; tony.luck@intel.com; kuo-
> lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; linux-kernel@vger.kernel.org; Andy
> Shevchenko <andriy.shevchenko@linux.intel.com>
> Subject: Re: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings
> terminated by newline
> 
> On Thu, May 14, 2020 at 10:08 PM Babu Moger <babu.moger@amd.com>
> wrote:
> > > -----Original Message-----
> > > From: Reinette Chatre <reinette.chatre@intel.com>
> > > Sent: Wednesday, May 6, 2020 6:50 PM
> > > To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> > > tony.luck@intel.com
> > > Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com;
> mingo@redhat.com;
> > > Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> > > linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>;
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Subject: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings
> terminated
> > > by newline
> > >
> > > The user input to files in the resctrl filesystem are expected to be
> > > terminated with a newline. Testing the user input includes a test for
> > > the presence of a newline and then replacing the newline with NUL
> > > byte followed by comparison using strcmp().
> > >
> > > sysfs_streq() exists to test if strings are equal, treating both NUL and
> > > newline-then-NUL as equivalent string terminations. Even more,
> > > sysfs_match_string() exists to match a given string in an array using
> > > sysfs_streq().
> > >
> > > Replace existing strcmp() comparisons of strings that are terminated
> > > with a newline with more appropriate sysfs_streq() via the
> > > sysfs_match_string() API that can perform the match across the different
> > > mode strings that are already maintained in an array.
> > >
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > > ---
> > >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 32 ++++++++++++++------------
> > >  1 file changed, 17 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > index c60a3b307f7d..e70694892c02 100644
> > > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > @@ -1408,12 +1408,11 @@ static ssize_t rdtgroup_mode_write(struct
> > > kernfs_open_file *of,
> > >  {
> > >       struct rdtgroup *rdtgrp;
> > >       enum rdtgrp_mode mode;
> > > -     int ret = 0;
> > > +     int user_m;
> > > +     int ret;
> >
> > This is bit confusing here. Mode and user_m should have been of same type.
> 
> It can't. If you compare enum to int you will need the explicit (weird) casting.

Ok. Got it. That is fine then.

> > You can define user_m to user_mode to be very clear.
> 
> > You can completely remove "mode" and directly use rdtgrp->mode instead. It
> > is left to you.
> >
> > > > -   /* Valid input requires a trailing newline */
> > > -     if (nbytes == 0 || buf[nbytes - 1] != '\n')
> > > +     if (nbytes == 0)
> > >               return -EINVAL;
> > > -     buf[nbytes - 1] = '\0';
> > >
> > >       rdtgrp = rdtgroup_kn_lock_live(of->kn);
> > >       if (!rdtgrp) {
> > > @@ -1425,11 +1424,17 @@ static ssize_t rdtgroup_mode_write(struct
> > > kernfs_open_file *of,
> > >
> > >       mode = rdtgrp->mode;
> > >
> > > -     if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> > > -         (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> > > -         (!strcmp(buf, "pseudo-locksetup") &&
> > > -          mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> > > -         (!strcmp(buf, "pseudo-locked") && mode ==
> > > RDT_MODE_PSEUDO_LOCKED))
> > > +     ret = sysfs_match_string(rdt_mode_str, buf);
> > > +     if (ret < 0) {
> > > +             rdt_last_cmd_puts("Unknown or unsupported mode\n");
> > > +             goto out;
> > > +     }
> > > +
> > > +     user_m = ret;
> > > +     ret = 0;
> > > +
> > > +     /* Do nothing and return success if user asks for current mode */
> > > +     if (user_m == mode)
> > >               goto out;
> > >
> > >       if (mode == RDT_MODE_PSEUDO_LOCKED) {
> > > @@ -1438,14 +1443,14 @@ static ssize_t rdtgroup_mode_write(struct
> > > kernfs_open_file *of,
> > >               goto out;
> > >       }
> > >
> > > -     if (!strcmp(buf, "shareable")) {
> > > +     if (user_m == RDT_MODE_SHAREABLE) {
> > >               if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> > >                       ret = rdtgroup_locksetup_exit(rdtgrp);
> > >                       if (ret)
> > >                               goto out;
> > >               }
> > >               rdtgrp->mode = RDT_MODE_SHAREABLE;
> > > -     } else if (!strcmp(buf, "exclusive")) {
> > > +     } else if (user_m == RDT_MODE_EXCLUSIVE) {
> > >               if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
> > >                       ret = -EINVAL;
> > >                       goto out;
> > > @@ -1456,14 +1461,11 @@ static ssize_t rdtgroup_mode_write(struct
> > > kernfs_open_file *of,
> > >                               goto out;
> > >               }
> > >               rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> > > -     } else if (!strcmp(buf, "pseudo-locksetup")) {
> > > +     } else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
> > >               ret = rdtgroup_locksetup_enter(rdtgrp);
> > >               if (ret)
> > >                       goto out;
> > >               rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> > > -     } else {
> > > -             rdt_last_cmd_puts("Unknown or unsupported mode\n");
> > > -             ret = -EINVAL;
> > >       }
> > >
> > >  out:
> > > --
> > > 2.21.0
> >
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

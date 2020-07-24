Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E562073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="bdsFIl9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgGXHGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:06:34 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:52612
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbgGXHGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O92psmYm/nXTEEKgaJWWfjNDtYihBzG0FmNqmYY0ntfDenZpLVNHsKwcb5Zl2wO3l20aJqG/25K1mVl92zgplXu51wm9h3ncuikRbuH40NX0SlVGII3V4poVMBU3+ZMoqjP5xGH7j2BhXpSGLXC1R9YrmSkeIvsZldN3FibwOS8SUAbk0DBWWNa5CkXEG3Ug8XwTrx43Kw8E5Nn6z4wKyy/rwWibNBwcb3REXOoBxwhJSf1NwQiH1CbYXpEPft6DjZOPjDio/GDoFDk2Ir70poCpFJMR63e4vfeDeXfzErPUuFesbBDBevO2/MicTLX9yeJWhQUSaNthmKxlLptBUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCp7RcgaieN8p0Exjrpy3Yu090OEmGK35vQF6J3fB8Y=;
 b=Nu01lnlvn8DIjpCsAX9SB1rnZJxdYDyB6QpMiR70aAjVSrLAEUX2RF3P1kQ7xYzO2/Ulu6joqWnmta9KA6A5X4vVFBoWunMlBD3zyLdgrKa4Mg+Ko/upm/Xj8V2OdJ0qvuMT21ychEap5QvvPBlf9ch15TmthefqB2F6L0q4GgaNbeNifzprTsLqibYFwheEBbn5GdBthqeUublnVCP27x2yfkoOWruQlv+k/vlU6XbRCXSxOYtou0jf5DApmemHWuvczrjXloj+DsvAQ6YhgVhsNbycxLCED4WgFU2SwBgjNzyd+vY9B7olMGc9AMXlQm1xyFk7wkAkp0ZwvBmFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCp7RcgaieN8p0Exjrpy3Yu090OEmGK35vQF6J3fB8Y=;
 b=bdsFIl9Oz0cT+aOuIq5CzAP5NMMQMqJsmYfRITsFANnuZwEw5+4G3Sza+Q51icbiEZHWsL4UipiAlpX/FUBUf7CInTrL7qVqqNcbOAViGutRWKhE+DiXE0ITQhUZpBhuEAE9xGyxjJbmGrsh1qM3HZS35gr6wbLVngoNMqynIIw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4008.namprd03.prod.outlook.com (2603:10b6:a03:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:06:29 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c%4]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 07:06:29 +0000
Date:   Fri, 24 Jul 2020 15:06:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Message-ID: <20200724150611.40b17827@xhacker.debian>
In-Reply-To: <20200721222455.e99fb8660f69f61ad1bc8942@kernel.org>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225173001.6c0e3fb2@xhacker.debian>
        <20191226115707.902545688aa90b34e2e550b3@kernel.org>
        <20191226110348.146bb80b@xhacker.debian>
        <20191226121108.0cd1b078@xhacker.debian>
        <20191226182607.06770598a00507090a046951@kernel.org>
        <20200721222455.e99fb8660f69f61ad1bc8942@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::28) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0136.jpnprd01.prod.outlook.com (2603:1096:404:2d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend Transport; Fri, 24 Jul 2020 07:06:25 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 252f9aec-890b-4ced-4bec-08d82fa0165a
X-MS-TrafficTypeDiagnostic: BYAPR03MB4008:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4008A74A5CEA6F1B29F27371ED770@BYAPR03MB4008.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xogJztzqr8gU5SWQZeBVQDnRZ7UvW81fnp1kME76xACB3IAaHPVfBzrcQ298Z6mecY9yLZ8Sl6xomPjc801VOcFtK32FHA+jSARTd03aYCVmLMZWG4g6BB1gWAxQ2+vk9Q7mwGfNLHA5lIIX3w9j+eyizenZgCVIDrFGmuWn7QIKBWhv6HRflYHvKVOLZ9vkfHjpPNLNMH4B/U/lxshWJgLgdGTPIeFhOWizBSW/NyPPT7mJ2jEyF3lbzqqbQzxbuNoUrVgZnTizQy0yF4r3F62iqxl2pnXxktnHXC0EYnZVo24cqskjfGxV84V9wApEQnePPFGxUR52gsAS1FZjXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(9686003)(86362001)(4326008)(66556008)(8936002)(54906003)(26005)(8676002)(66476007)(7416002)(186003)(6916009)(956004)(16526019)(316002)(55016002)(66946007)(52116002)(478600001)(1076003)(4744005)(2906002)(6506007)(5660300002)(7696005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wey3KPK3DG0F87R3BKrYTPHvOyMZ2pCLnqlnUPHeQTN0rFnCRUQcPPU+e4ReGf3mG9dgqkLjpGUz9F32U1e0MIiS3qCnHKHF/6mU6uj67CWyGydm9PY0dpE5LypveetwZzWMvNc70HdGpSbalFVbZpNF70Ul7AXlEpVF7F+5sbcl0Y48mhSPtYSS9MJv5SsEAGzSkanBmI39PLWWQGMPDpPBRoflO6EGuXK9H9mT7AVqJm/dvyQaGVcEU7zpLAOKDrpP7jdPMJt41lYeJ2fzBPJfenJ78s87UucFVdft2cX+TaWDNJCq6Ao2kZnH8tOM1cJBhyzdKGiPr5c3XhjtDxlM9aQqWw0WxDR3PA3PxPGBSo0NiPDHdP9iZz71PlNOhkf5m7b80Pj/LJY1MhUPwKVBg/c8nvc/kyJT+UVI6zNAdNGzCXjLguyl5N0vkSQj8mmlqK5eCn7vGmb0yPLE3Ue7CaGtc0MFRwJ92UMtWQAOAUED4MbzvYzjR8IcQTpK
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f9aec-890b-4ced-4bec-08d82fa0165a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:06:29.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tI76fb9SpwylKFaQ1EnmOGqVfVCbp7Anz3FckNEPH/VmGAsObldMTDESNSOtVvVEvf6T3WNlAD3PloHmk6BMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Jul 2020 22:24:55 +0900 Masami Hiramatsu wrote:

> 
> 
> Hi Jisheng,

Hi,

> 
> Would you be still working on this series?

I will rebase the implementation on the latest code, then try to address
your comments and Mark's comments. I will send out patches in this weekend.

> 
> If you are still want to put a probe on func+4, it is OK if you can
> completely emulate the 1st instruction. (lr save on the stack and
> change the regs->sp)

Will check which is the better solution.

Thank you very much


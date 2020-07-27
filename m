Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8434C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8700B2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UWfXiwa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgG0Wze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:55:34 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:11594 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgG0Wzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:55:33 -0400
X-Greylist: delayed 695 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 18:55:30 EDT
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RMa23r022594;
        Mon, 27 Jul 2020 22:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=crPt+1lIPBnV2ff/FPBOnmgA993+VutUfAdNKrbFWbQ=;
 b=UWfXiwa3J31mJM1QQ2s3FsA3E9EyCpRPt+rel2XLD45dcqZDCvTsUCRST96yN8DhP7HI
 5Z8HNP0iPrz7wKj6467y2x2ffi7PUZtNGSt3sNXIDs8qWMQBro8dow4p7jbZQR7M7OQz
 QJ926Z1y/Wyd88QTShq68OUDfRpo59OUaIhV4dj914upc31nibXOVbUleRdRpSniSf6V
 FncoOTWNw65T2oU56UwT23oIz2GRmTm21AOQqtAoQCQViLuQ4umY+E1+cLyPnnLueXED
 /oVXQ61rWWEAPIn03I4t3fS5+BAZcaD7dxnPi3Apx3CfApTGwcb0CxCLjvXj58KtOBaR bA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx08-001d1705.pphosted.com with ESMTP id 32gct090sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 22:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt8ovY9g91/rg+DYnpBnwUU8CLVfHLf8bMXh4MH6ph9Wxrh/NDnDD0VliNZbojohMCEqWi5Bd2ayCvtCO8WK0xeLwiYoFXfiCh9gNcxP5TFK8Wo0jGF0Cg9j9JGFhNiOHqCU1gGbeY/nBgXsHxBbZkztcPkkpTya1q4ZcjmiRljSaQPQ5lZ9jkOU7W7MSgNRD+Ujsj9K0unGIuY9YbyBq5CVwgVLqqIkX7muYm8DrMcoXR7PbiBZRmIEeGaVlPBwf6bvH4xFQyouqxfaNEu3RN/DXfIAN2DE/n7T2+ztLbP42tQjUFyPhLTlHqHm9pbucFE1wc+7oTaS+8Vpc+xTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crPt+1lIPBnV2ff/FPBOnmgA993+VutUfAdNKrbFWbQ=;
 b=j9vKSiZ09tXfAm634zoD5ezjStC+1wUagkmhZebHbUhT3fs7qDg3E3ZhKYP65NCdMBVU90IRl7tbjYLBr/FIofFpGnIiErlW7QA2CvZ9tkxKDjDtbOD2kOtuTM/iCac0Kb118IkSC3FEMEkCF9BMvy4m/K7GUW2ZmS/pbCCygC+dKfyspWbTih7E3LmzSTeVAezaG0Ks5pmQ+mxDL3H94UX8yMCnkBOpaB73ndnDF8/GsBMjDS7BdH1+Lqa9/IeHYN0tAEAVITjh3LAw3aDZ2aGYWr8u2VJ6tN7d0fLLfUB+TwMcoNcWx7A4aU5VkcJ5BIbEHOmTyH2SIYXVjmhbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2103.namprd13.prod.outlook.com (2603:10b6:910:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.15; Mon, 27 Jul
 2020 22:43:45 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::5c0c:3d3a:c493:efa]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::5c0c:3d3a:c493:efa%11]) with mapi id 15.20.3239.015; Mon, 27 Jul 2020
 22:43:45 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Laura Abbott <laura@labbott.name>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- voting procedures
Thread-Topic: [Ksummit-discuss] Linux Foundation Technical Advisory Board
 Elections -- voting procedures
Thread-Index: AQHWZF1gDhw/mh/6mU6OqJlNSe7/qakcBQog
Date:   Mon, 27 Jul 2020 22:43:45 +0000
Message-ID: <CY4PR13MB1175DCFB41F2FB2F47E43A9CFD720@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name>
In-Reply-To: <ade3420c-89fd-bed0-52e3-a0396eaeda2d@labbott.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: labbott.name; dkim=none (message not signed)
 header.d=none;labbott.name; dmarc=none action=none header.from=sony.com;
x-originating-ip: [192.34.114.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d977d729-e8c6-477f-251e-08d8327e8577
x-ms-traffictypediagnostic: CY4PR1301MB2103:
x-microsoft-antispam-prvs: <CY4PR1301MB21038CD1074882BD9B3EF6DBFD720@CY4PR1301MB2103.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BswgG5BtwjtkUFUILNkQCWQVMpct1zyR5isRmHMhvLISE8Vh9TeAK9PIt2cuYtogKa0UlklBjjBsbApU2xGbGZ7tnbLy3gm60U5bOTR55BSkiMNdVd9pwiu6jH1zyga+hBDJhWSAYYMLLx96ZRh+AtGEcNwxV13K7fmf+Pvfepw+esc51kF/tZvBP3wv2YkNF8JgGwnZ9eH4NEJolb2kvbsJKmJCe7P6M+vQiNUQQMlADsH1THTR3b6L5Od2mwvZ0BrsHxiNl+ugrUuQBeMCCT/ImaK5goST9p2wLBnIik87u/SIzn6krQIF2cuZplrii2+WWv0KukT9cPJAI176CA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(8676002)(52536014)(5660300002)(316002)(33656002)(186003)(9686003)(26005)(8936002)(83380400001)(55016002)(66476007)(71200400001)(6506007)(64756008)(66446008)(2906002)(110136005)(66946007)(478600001)(7696005)(86362001)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NXuufsZbKfr3BC2CykBS8nnNztgEcI2WkxhQYLKRHx8n99Y1NKOO/HojIUfL0pFpu6RenHl90cYw3K44ubJxSoWGdJ3fgiN+c6NHPi3pV+EukR104tCsVE2PG75mifw8OMuF9gt0sxeJOVSu08KFWGjSu1cn4KFHgn2p4PZ/lq8WpAVwyiTl/K1qqfALgnxRPsfnpXYj47Vbkj6Hz05b7PsB9rytOerNp2veTzft2H/Kvb+Yqa8onTi3d1CoHKEFGsR/3uX0uOVVisnKm1DciHdrnTuiY2AdN0Hb8mSHyBZQaF3cwa8HnsOxSCktcHjdLH7PLya7e7ORE4DKFrEDpT79tOvTwVSclSEzHsSrIuOg83NNv36tYdaiKD0tGPBaq5fTO4CxPP5OoUkmMcyS5/k6LmbK5HUafd0pirYcWQEHsCe5LmPbDAJsE8IDrydVNWqrX25C3j4MWxu2XzHs+1DJJk3a5CimSvpo6G7XUWA7gxhsAJOuE1EJpLO/595L/Z9tcn1n+N3gU5P7DnGRr4COW8N6TdtLTCfWOU7DbbxcpA+cM2y8cdBIOcHJUe6U7jVZZllvSGk7jMk3a3dsEUZnef9UuHOq/BacHR4+i9c7U66GWK563ObLnzTygi8vnBq3uOrhsNDduGg2rp7rJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR13MB1175.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d977d729-e8c6-477f-251e-08d8327e8577
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 22:43:45.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QSzcVyB8MUyut6LG1lTmWedfMO+OyujL30VTSNsd8IqZ4L62jrF2NJiWdQwC0R3bV9ZA8Nkutoz9nfjgtCR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2103
X-Sony-Outbound-GUID: XEK7KfHPHSEVWQwIbT3xtVMv-S7GbrYW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_15:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1011 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From:  Laura Abbott
>=20
> On behalf of the Linux Foundation Technical Advisory Board (TAB), I'd
> like to announce the voting procedures for the 2020 TAB elections.
> The pool of eligible voters will consist of the following:
>=20
> 1) All attendees of the Linux Plumbers conference (i.e. kernel summit)
>=20
> 2) Anyone who is not a kernel summit attendee will also be eligible to
> vote if the following criteria are met:
> -- There exists three kernel commits in a mainline or stable released
> kernel that
> --- Have a commit date in the year 2019 or 2020
> --- Contain an e-mail address in one of the following tags or merged
> tags (e.g. Reviewed-and-tested-by)
> ---- Signed-off-by
> ---- Tested-by
> ---- Reported-by
> ---- Reviewed-by
> ---- Acked-by
>=20
> We will be using the electronic voting method that we used in 2019. All
> Linux Plumbers Attendees will automatically receive a ballot. Anyone
> who is otherwise eligible to vote should e-mail
> tab-elections@lists.linuxfoundation.org to request a ballot. The deadline
> for requesting a ballot is August 17, 00:00 UTC (one week before
> Linux Plumbers)
>=20
> For those who would like to know the thought process behind this:
>=20
> Last year, we successfully used electronic voting for the TAB
> elections. Given the circumstances of this year, we have no other
> reasonable option for voting. While we could continue to limit voting to
> kernel summit attendees, one of the goals of moving away from in person
> voting was to potentially expand the voter pool. Since kernel summit is
> not being held in person this year, it makes sense to expand the voting
> pool at the same time.
>=20
> We will be sending a call for nominations and announcements about
> when voting will start at a later date.
>=20
> If you have any questions, feel free to reach out to the tab at
> tab@lists.linuxfoundation.org

I know it's a lot of work to put this together.  Thanks very much for this
new process.  I think it's a great change.

Regards,
  -- Tim

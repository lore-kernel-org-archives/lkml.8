Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C988C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DC220809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="EXwOVdKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgG3XOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:14:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:38325 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG3XOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:14:42 -0400
IronPort-SDR: TjEQH3UWDvpKEFTtLl+Z59RY1eNOXCES4+UR3GaDVzYt3bc7jnLvLc8EJ6ywUxmzii48xqga6K
 dpbcOZWkOF+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="152919387"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="152919387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 16:14:42 -0700
IronPort-SDR: IFYwSRaF5O4X/gKNGQKg4bwcIJczfU14pZFUzwQxcq/fSAhpP1JdLrppyv1/20AP1WJ1wGjnyj
 4Y8QDdQnCqBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="435225019"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2020 16:14:41 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jul 2020 16:14:41 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 Jul 2020 16:14:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Jul 2020 16:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHNzc/UXd39adJZaCEa1rtYrPoHFlPVYSvQDGwbx+yHN2QM/377qvsOAfsBNhVM1A2xG9jACgCBINdumr7/a/iyBdfjLPud55bzpRU+dGle+1gHks+omozWQb8+VfsxXiZ57pxm7dSHLE3dvE2OWvO+CfvFh27fvfRT9GuZhtfMIHhhHCw4LtYU/xqjBbN1c9KwDbXbzmVE/m/WevQlnYO1oBRGyQrKdjufAjWAyupDYNYxbdLYO0ZuBW9NgFX23On6ObXMG5tDQUn1TMSjn+MsjAhG03c1MUcrk7Oa4zGviqW64ZOtNm9eH13mimjZPs0EaGgYkqrL4kj/x7XvBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23+r1LKYnpsO0SJe6CesPUZKr7zk96aoUiwt0dlnZUM=;
 b=OT/InI9fEtrWwr669rumzrN6W03N2HdHlSflnyG3omyoJDTfWcB5dZwECGG+DetE/mY9tM0Ar+QqEVLXOqSlk3MwQGNdfNmViyghPSp+2hT65EM6LtvkfGowH/kKZI9hyK0CCsXgGZLtsKiORKnIVhMmaKOtKCxRZWv2Yx0KwUg8uEduJgI/tRe6RLYyzCLLVQabzFPKr3AlLAjRFJjGHVc7sTX/uN79kQFysusvYZ16wwCTzMZGFc1dZPw1o9d7qWL1hmg7m5WHco2LTFkmMTrtrhMzXRj/re6gmFAOGY5UUk0Olzs6N+qvkS1Pa7AvqR8XgkjHDZLkqN9RoyLpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23+r1LKYnpsO0SJe6CesPUZKr7zk96aoUiwt0dlnZUM=;
 b=EXwOVdKiKG5lOwI8XVTbsTks2NH0g6KFoa/gGmta/3xmDO/Ou+x5JhKELfBSSwLA6Bc+RhZ8xLvFd1y9eUAtWbjbGJOLJX5IxQz2Z3+y3UIOlDdFxcJxlu9Jq6BMR8IicO8Z9v/JmEw2BRUwk/PVMptqq6FJR5kho1J7/xqMc+Q=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 30 Jul
 2020 23:14:40 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::7199:c7d8:e0fa:d595]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::7199:c7d8:e0fa:d595%10]) with mapi id 15.20.3216.034; Thu, 30 Jul
 2020 23:14:40 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Thread-Topic: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Thread-Index: AQHWZsSZvlUsJzdXqkqf6LtgMiR0NqkgvJWAgAAAwwCAAADCgIAAALGQ
Date:   Thu, 30 Jul 2020 23:14:39 +0000
Message-ID: <MWHPR11MB1518F06A499594BCA675A5E491710@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-2-azhar.shaikh@intel.com>
 <20200730225921.GC3145664@google.com>
 <MWHPR11MB15189A9180898261A92DD7C091710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730230447.GE3145664@google.com>
In-Reply-To: <20200730230447.GE3145664@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.236.160.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e20b184-5c18-42d8-20de-08d834de55d2
x-ms-traffictypediagnostic: MW3PR11MB4714:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB47144D4185897B5CF8E4101C91710@MW3PR11MB4714.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOen9yAUCb2zGn4RG5eyeptcLDQxNUPvxV1kNcK3X/ZHeTtnvNqHZNyBRwFb0ydGkvSqfL1AdgmSGdW8hydcr56hyIkHZ06cm90T3ozZ3b/dcGR7b/Frwhz3Uw0GN7ZA+3jGhcS7ENB8bwID9ruhlzIb7qBvDFUrjesCXW/DOqN0aOqvVtxGZXaPXBtgme06tI+ZBBbe2E3QK9uB7ifEBGLcOXzgBqGWaU4gzMd9UeJNPomi/x/VTNuoN10p+qR9WJzVpfHTTNXiiw2ZRTZgKQjwqgpV2GODua6rzFcmrVK5yEd+n1eDAK1sceZge5AmSbHgyCtr4ojT0P6aIyZrEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(54906003)(478600001)(52536014)(8936002)(86362001)(4326008)(8676002)(9686003)(55016002)(53546011)(2906002)(76116006)(4744005)(66446008)(26005)(71200400001)(316002)(5660300002)(6506007)(33656002)(66476007)(6916009)(83380400001)(66556008)(7696005)(64756008)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mCHQgR8Ls9ozHZCpuq+OyrdgvWjMaM7zY68sq/90cNxQlB8o/mEWMCaABUgFKvYZXfyksnD7qO0e8zddtZXYUHh2+XqRv2n1VB+iGkc+CXlHf8hAVMt6HH5XfuI6Mmcdm+cPufoSgw8FD59WC9FAuCLWRtar1MJlBedgVO5GMI4IOv9gePhe/wmc3eLYBycRnL+tmrvc9k6Ci+xtuL2p4/74kDaBy7xS0vnEZDGRAJ4DiJQMB/JJQyDd6/0u/vk7D7umwfz0QMT721KSg5z7XvatciRi+ZG71V5yU+zt9NQmaWtqIaOYYVpMXzii9W7MAMOVcU9bbUL1R9XPWEClbRN5aMLMta+lcx0nQxbQyuzYkVSD1CUUHtjwfb2EBAcZrt91YVjPzT8z8+tcHRbgZLs4MertJ/g217U7KdtqtmwnGy4yhIxNlLjl0hBzeqkh3ogXd4/8H8aTZFsEVDYQsCAdBrwVV2xOnIUXQbWG2+IrJ+1VT5PeMbFk7G8oyZAA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e20b184-5c18-42d8-20de-08d834de55d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 23:14:39.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS6kicaN9dYhOyc2kAlZQol4/4jNNNBF9ozy5mS8bwi8659WjS5uJJqSYvNnnBFTLFJ26vb6lDAHQgCiB9iLWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Thursday, July 30, 2020 4:05 PM
> To: Shaikh, Azhar <azhar.shaikh@intel.com>
> Cc: bleung@chromium.org; enric.balletbo@collabora.com;
> groeck@chromium.org; linux-kernel@vger.kernel.org;
> heikki.krogerus@linux.intel.com; Patel, Utkarsh H
> <utkarsh.h.patel@intel.com>; Bowman, Casey G
> <casey.g.bowman@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum
> values to usb_role_switch_set_role()
>=20
>=20
> On Thu, Jul 30, 2020 at 11:02:28PM +0000, Shaikh, Azhar wrote:
> > Hi Prashant,
> >
> > >
> > > Please add the list of changes in each version after the "---" line.
> >
> > I have added those in the cover letter.
> > >
> It is good practice to add these to the individual change too, so that th=
e
> reader doesn't have to go back to the cover letter to determine what has
> changed in each patch.

So are you suggesting to move it from cover letter to individual patches?
But then isn't the same thing what cover letter is for?

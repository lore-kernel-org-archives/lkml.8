Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94887C52D4F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F99246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="JDeYKeru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389624AbgB0ORA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:17:00 -0500
Received: from mail-bgr052103193092.outbound.protection.outlook.com ([52.103.193.92]:24422
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389583AbgB0OQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIMJkxQ6KgA/OIB291azyOor6jbx6EspYkcELspgFFc9Nnlx4kMz66rreFz3ySwDILmm/9FNl8TSbiBljH+ahG4setfS1mH2tG1PwQ05TDe1zexMJY2TwTrG4V+lWH4I5UsPhoSjyqaAOynd+w5uy9sIerIm2cvGeJIYHlYlzID5vdkg0eLX7krwNR3IL853s0CLuIw6Xa1eSn3fgoSnrqdV0Y0Aeq+zfvWb9qCH7GU4TH/3SbgWmTUlYOX3CcQgZUu4FsehnlBUk4LRPJEN5+bxjzDyvuleCgqcPuWvf3o2tdxoDBcvWbFpHZYu3WCxcEwwVyIM9UTS/neZ1E1m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsm9bpDebIopFARQDOq1l6M+j8I+d1K+0HBXt3MZSjQ=;
 b=F0Wr6IDsUGye3Zcy+94qOMU6CWQg2UMlARkn6lqZD9GS00skJ3jwChOSGp+4fCOcbyIbxKIJ3CzuiisGcpYZ1osJSV+ApYWA9YOKLQjv3RZd3I6R12Xm3hlDTMpC0w46sQQAof9TKFHzgoIRy47nvQyRegBxdPSGbGBGUjo9uIcKBD0tBWY55Z5vfkYYcmjwCzomvOkbaKCPlyRzo9uAD8YScyz2t8XSDQmUm6Zqh3/n4L2uZEcnW/X4hcRM0uLfiU9SNF2TFV1Wd2G2VYvA6pJSoTH2tm06YzDg+rDR+mD6gSJixS/dIU0ztPXb4KQyEOSA68qJawvRYSk2Omyrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsm9bpDebIopFARQDOq1l6M+j8I+d1K+0HBXt3MZSjQ=;
 b=JDeYKeruMCC5vElgBWwvf3Z5G+O+WX/ZIAobOazFe8mI+I9hOmPePgCfn6PElkzy+uq4w8kzsN6uji3k/omOWAtjoXQCermzHhR220WvPbYaQCPw/twxbV81ls9nBK9SqEjqYssAX6c9sLYKDkQAUG2jcdw0bWPRBKxJBH1CDco=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3096.apcprd01.prod.exchangelabs.com (20.178.134.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Thu, 27 Feb 2020 14:16:48 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::684a:9e0b:7e12:18bd%4]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 14:16:48 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Re-configuring BIND DNS Servers for CentOS Web Panel Web Hosting
 Control Panel on Amazon AWS Cloud
Thread-Topic: Re-configuring BIND DNS Servers for CentOS Web Panel Web Hosting
 Control Panel on Amazon AWS Cloud
Thread-Index: AQHV7Xh1XpuVCWO+y0GjRnukMZa3zQ==
Date:   Thu, 27 Feb 2020 14:16:48 +0000
Message-ID: <SG2PR01MB2141E38AF32C506180AC391C87EB0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:b9d6:368a:abe6:e44b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef34b124-a9be-4d51-b12c-08d7bb8faf09
x-ms-traffictypediagnostic: SG2PR01MB3096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB30961A7FB1CB3234D21A434487EB0@SG2PR01MB3096.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:SPM;SFS:(10001)(10009020)(6019001)(396003)(136003)(366004)(376002)(39830400003)(346002)(47630400002)(269900001)(279900001)(199004)(189003)(4326008)(6506007)(186003)(66946007)(64756008)(66446008)(76116006)(66476007)(66556008)(316002)(2906002)(966005)(508600001)(55016002)(9686003)(33656002)(6916009)(107886003)(86362001)(16799955002)(30864003)(5660300002)(52536014)(71200400001)(7696005)(81166006)(8936002)(8676002)(15188155005)(15974865002)(81156014)(416054008)(19623455009)(47845001);DIR:OUT;SFP:1501;SCL:5;SRVR:SG2PR01MB3096;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xso9c4wV/jeP7Tdq+ibAf+kWL5ZmxRmFIYw9GPxMDAUpiXavI+lUCnlp2h+GaHJoz9oG+YzVTtDsC9nPB3KV3vRvlT2ah29mGKZAx6WpSoMb5mf5vLhn82ACUSfMRHtriqtz/aCUKjN1NurTSs1fBNIaVDnE688B1Rq55QPY/A+pUjdxAy6aQIer1vV/tGOXobKpStQlPSyhCKBT2/gIpQqByzPKY+GHtaY/aqg3K7raoPs7wcAvrUvS21FkqBI+5MdQaFemYUC49rhfzEzMh6deO0GLq6A3TQxXya+5c64N65QHs9iJ8wZ4nqlE/VSDHUcKdI59n9TngOZAwUjwRS+/bQkZMm96IgFQ9nwfRgDXl/IjtT9Mcx3lAiwEr9XaPJJUQdZrmB4LPelN2KehbVSv/HDX9Y1HuoRhFKgWgTpsXWoEG3/qQHExVCT+eNpOaelmQEYODqBGiCaECpUkIDqeTemDEttqSpzJZY8e6LnZOCgE5tPyxYOAJflIks/EtAcDvLAcx7fxajqaugsFv10eAV4en4upD99uSFevUXTFk/mI3ZkhWMW0s8GB/I0yTLHUIYwG0AFxFuBECyvfXDw/i7LcgT0ZLPzns+hNg2nOBjWvJT6fLSfqvBkNw+jU3W8S9UUH3snAQyWs02tZTqYJ9en2tCOq5mG0mJ6q45A6ix4vwX62H4iAj8BziWfKply9qfFJorP3fYcw3+rTXMHYpLtFJcVf264JzP1s88fAeYzhB3WHriS8mXHeBl16F2boySKQ+yTeEd8XBlCDQF0VCZU8qe90oycXtJYa8XZg8ns9tc6dL0TvraIeHMEciTXKi7SJLcYiPl8e9BojZ4TE7woh2tHA0FL01riy0a1AO1wZOcpzf0gAtCg99Q0a
x-ms-exchange-antispam-messagedata: Ggyg1NaRi3GDzYlGYG6adf3sipmPIiHPUKG9gMMcwi0WKuR4y2IiIEmafMtY2KA9Ip7qt3xCzRiHYxirpq2K1GK4+8/W6IDxE2yUFxQ5+kXg76uY8cTS0Ry+BOV40hGZy6ryGO8lsmGe+EEa7iCIP5RBChFgshyEe8MS3i5weSEYyAxP7aSW1jys+FrnblFvRlZ1mhMr3XK9uifcIeqvsQ==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef34b124-a9be-4d51-b12c-08d7bb8faf09
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 14:16:48.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcjJnYomA3/H7od7J7axflcqWreFIkBl4DZMGrfKIZROm3OZBJ1zEuLjPYYOTbElHPIu/loz2X7VDEwupAvgc3UWCdKl+T+oc4ZN93C9Kug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re-configuring BIND DNS Servers for CentOS Web Panel Web Hosting C=
ontrol Panel on Amazon AWS Cloud=0A=
=0A=
Author: Mr. Turritopsis Dohrnii Teo En Ming, Singapore=0A=
Date: 27 Feb 2020 Thursday=0A=
=0A=
Rationale for Re-configuration of BIND DNS Servers for CentOS Web Panel=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
I have originally followed the approach for cPanel where there are 2 DNS-ON=
LY servers and one or more cPanel webservers. However, CentOS Web Panel =0A=
implements DNS Clusters differently. Hence I have to re-configure BIND DNS =
Servers for CentOS Web Panel web hosting control panel.=0A=
=0A=
PREREQUISITES=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Part 1 of the series: Mr. Teo En Ming's Guide to Deploying CentOS Web Panel=
 (CWP) Web Hosting Control Panel on Amazon AWS Cloud=0A=
=0A=
Redundant Blogger and Wordpress blog links:=0A=
=0A=
[1] https://tdtemcerts.blogspot.com/2020/02/mr-teo-en-mings-guide-to-deploy=
ing.html=0A=
=0A=
[2] https://tdtemcerts.wordpress.com/2020/02/23/mr-teo-en-mings-guide-to-de=
ploying-centos-web-panel-cwp-web-hosting-control-panel-on-amazon-aws-cloud/=
=0A=
=0A=
Part 2 of the series: Setting Up Mail Server Operation for CentOS Web Panel=
 Web Hosting Control Panel on Amazon AWS Cloud=0A=
=0A=
Redundant Blogger and Wordpress blog links:=0A=
=0A=
[1] https://tdtemcerts.blogspot.com/2020/02/setting-up-mail-server-operatio=
n-for.html=0A=
=0A=
[2] https://tdtemcerts.wordpress.com/2020/02/25/setting-up-mail-server-oper=
ation-for-centos-web-panel-web-hosting-control-panel-on-amazon-aws-cloud/=
=0A=
=0A=
THIS guide is Part 3 of the series.=0A=
=0A=
EXTREMELY DETAILED INSTRUCTIONS OF TEO EN MING'S GUIDE=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
=0A=
Login to Amazon AWS Console.=0A=
=0A=
Setting Up Secondary/Slave DNS Server=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
On the EC2 Dashboard, click Instances.=0A=
=0A=
Click Launch Instance.=0A=
=0A=
Search for centos in the AWS Markpetplace.=0A=
=0A=
Select CentOS 7 (x86_64) - with Updates HVM (free tier eligible).=0A=
=0A=
Click Continue.=0A=
=0A=
Select t2.micro (free tier eligible).=0A=
=0A=
Click Next: Configure Instance Details.=0A=
=0A=
Network: Teo En Ming VPC=0A=
=0A=
Subnet: Public subnet | us-east-2a=0A=
=0A=
Click Protect against accidental termination.=0A=
=0A=
Click Next: Add Storage=0A=
=0A=
Size (GiB): 8=0A=
=0A=
Click Next: Add Tags=0A=
=0A=
Key =3D Name=0A=
=0A=
Value =3D slave=0A=
=0A=
Click Next: Configure Security Group=0A=
=0A=
Click Select an existing security group=0A=
=0A=
Select NameServers=0A=
=0A=
Click Review and Launch.=0A=
=0A=
Click Launch.=0A=
=0A=
Select Choose an existing key pair.=0A=
=0A=
Key pair name: cwp=0A=
=0A=
Click Launch Instances.=0A=
=0A=
Click Instances.=0A=
=0A=
Select slave, right click and select Networking > Manage IP Addresses.=0A=
=0A=
Click Allocate an elastic IP to this instance.=0A=
=0A=
Click Allocate.=0A=
=0A=
Click Associate this Elastic IP Address.=0A=
=0A=
Instance: slave=0A=
=0A=
Click Associate.=0A=
=0A=
IPv4 address of Secondary/Slave DNS server is 3.12.224.179=0A=
=0A=
$ ssh -i cwp.pem centos@3.12.224.179=0A=
=0A=
$ sudo passwd=0A=
=0A=
$ su -=0A=
=0A=
# yum -y update && yum -y install wget=0A=
=0A=
# hostnamectl set-hostname ns2.teo-en-ming.com=0A=
=0A=
# cd /usr/local/src && wget http://centos-webpanel.com/cwp-el7-latest && sh=
 cwp-el7-latest=0A=
=0A=
Started installing CentOS Web Panel at 9:00 PM on 26 Feb 2020 Wed.=0A=
=0A=
Completed installing CentOS Web Panel at 9:05 PM on 26 Feb 2020 Wed.=0A=
=0A=
Total duration: 5 mins.=0A=
=0A=
#############################=0A=
# =A0 =A0 =A0CWP Installed =A0 =A0 =A0 =A0#=0A=
#############################=0A=
=0A=
Go to CentOS WebPanel Admin GUI at http://SERVER_IP:2030/=0A=
=0A=
http://3.12.224.179:2030=0A=
SSL: https://3.12.224.179:2031=0A=
---------------------=0A=
Username: root=0A=
Password: ssh server root password=0A=
MySQL root Password: =0A=
=0A=
#########################################################=0A=
=A0 =A0 =A0 =A0 =A0 CentOS Web Panel MailServer Installer =A0 =A0 =A0 =A0 =
=A0=0A=
#########################################################=0A=
SSL Cert name (hostname): ns2.teo-en-ming.com=0A=
SSL Cert file location /etc/pki/tls/ private|certs=0A=
#########################################################=0A=
=0A=
Visit for help: www.centos-webpanel.com=0A=
Write down login details and press ENTER for server reboot!=0A=
Please reboot the server!=0A=
Reboot command: shutdown -r now=0A=
=0A=
# reboot=0A=
=0A=
REFERENCE=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Guide: Slave DNS Server & Manager - DNS Cluster=0A=
=0A=
Link: https://wiki.centos-webpanel.com/slave-dns-server-manager-dns-cluster=
=0A=
=0A=
REFERENCE=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Guide: Slave DNS Server & Manager download version=0A=
=0A=
Link: https://wiki.centos-webpanel.com/slave-dns-server-manager-download-ve=
rsion=0A=
=0A=
Login to the CentOS Web Panel Admin Panel on the Slave.=0A=
=0A=
From the left menu, click on CWP Settings, then select Edit Settings.=0A=
=0A=
Admin Email: ceo@teo-en-ming-corp.com=0A=
=0A=
Check Activate NAT-ed network configuration.=0A=
=0A=
Click Save Changes.=0A=
=0A=
Create a New Account on the Secondary/Slave DNS Server=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
=0A=
From the left menu, click User Accounts, then click New Account.=0A=
=0A=
Domain name: teo-en-ming.com=0A=
=0A=
Username: slave=0A=
=0A=
Package: default=0A=
=0A=
Click Create.=0A=
=0A=
Download Slave DNS Manager and upload it to public_html folder on the Secon=
dary/Slave DNS Server=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
ssh -i cwp.pem centos@3.12.224.179=0A=
=0A=
su -=0A=
=0A=
cd /home/slave/public_html=0A=
=0A=
wget http://dl1.centos-webpanel.com/files/cwp/addons/cwp-slave_dns.zip=0A=
=0A=
unzip cwp-slave_dns.zip=0A=
=0A=
mv slave_dns/* .=0A=
=0A=
rm -f index.html=0A=
=0A=
Fix file permissions on the Slave DNS Server=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
chown -R slave.slave /home/slave/public_html/*=0A=
=0A=
MySQL: Create User and Database on the Slave DNS Server=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
=0A=
From the left menu, click SQL Services, then click MySQL Manager.=0A=
=0A=
Click Create Database and User.=0A=
=0A=
New Database for user: slave=0A=
=0A=
Database Name: slave=0A=
=0A=
Click Create Database.=0A=
=0A=
Edit file /home/slave/public_html/inc/db_conn.php.sample and enter your dat=
abase connection details=0A=
=0A=
# nano /home/slave/public_html/inc/db_conn.php.sample=0A=
=0A=
# mv inc/db_conn.php.sample inc/db_conn.php=0A=
=0A=
# mysql slave_slave < sql/slave_dns.sql=0A=
=0A=
# nano /etc/sudoers.d/slave=0A=
=0A=
slave =A0ALL=3D NOPASSWD: /bin/systemctl start named=0A=
slave =A0ALL=3D NOPASSWD: /bin/systemctl stop named=0A=
slave =A0ALL=3D NOPASSWD: /bin/systemctl restart named=0A=
slave =A0ALL=3D NOPASSWD: /bin/systemctl reload named=0A=
slave =A0ALL=3D NOPASSWD: /bin/systemctl status named=0A=
slave =A0ALL=3D NOPASSWD: /bin/systemctl is-active named=0A=
=0A=
=0A=
# touch /etc/named/slave.conf=0A=
=0A=
# chmod 771 /etc/named=0A=
=0A=
# usermod -a -G named slave=0A=
=0A=
# chown slave.named /etc/named/slave.conf=0A=
=0A=
# mkdir /var/named/slave=0A=
=0A=
# chown named.named /var/named/slave=0A=
=0A=
Edit File: /etc/named.conf and add this in options section before closing }=
=0A=
=0A=
masterfile-format text;=0A=
=0A=
Add after options{} where other include lines are specifed=0A=
=0A=
//Slave dns configuration=0A=
include "/etc/named/slave.conf";=0A=
=0A=
Now you can login to Slave DNS Manager GUI by using a domain link of the ac=
count you have created.=0A=
=0A=
Go to http://3.12.224.179/~slave/index.php?login=0A=
=0A=
Default login for Slave DNS Manager GUI admin/root=0A=
Username: root=0A=
Password: FX8QKxvQ=0A=
* Please change the default password after the first login=0A=
=0A=
Adding WebServers to Slave DNS Manager=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
- On Slave DNS manager GUI create a new user for each server or use a singl=
e for all webservers if you plan to transfer accounts from one to another w=
ebserver.=0A=
=0A=
Click Add New User.=0A=
=0A=
Username:=0A=
=0A=
Password:=0A=
=0A=
Email:=0A=
=0A=
API Key:=0A=
=0A=
API Secret:=0A=
=0A=
Domain Limit: 1000000=0A=
=0A=
Click Save.=0A=
=0A=
- On Master CentOS Web Panel WebServer go to DNS Functions -> Slave DNS Man=
ager=0A=
=0A=
Buy CWPPro license first. It is only USD$1.49 compared to USD$20 for the li=
cense of cPanel. I can't afford to buy the license for cPanel, hence =0A=
I have to settle for CentOS Web Panel.=0A=
=0A=
Then ssh into your Master CentOS Web Panel Webserver.=0A=
=0A=
# sh /scripts/update_cwp=0A=
=0A=
You have successfully upgraded to CWPpro.=0A=
=0A=
On the Master CentOS Web Panel, Go to DNS Functions -> Slave DNS Manager=0A=
=0A=
API Key:=0A=
=0A=
Secret Key:=0A=
=0A=
Base URL: http://3.12.224.179/~slave=0A=
=0A=
Master Server IP's: 3.21.30.127=0A=
=0A=
Click Submit.=0A=
=0A=
Master CentOS Web Panel WebServer configuration=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Edit File: /etc/named.conf and add this in options section before closing }=
=0A=
=0A=
//Slave dns configuration=0A=
allow-transfer {3.12.224.179;};=0A=
allow-recursion {3.12.224.179;};=0A=
also-notify {3.12.224.179;};=0A=
masterfile-format text;=0A=
=0A=
# named-checkconf=0A=
=0A=
# systemctl restart named=0A=
=0A=
REFERENCE=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Guide: How to setup DNS cluster on CWP 1 =96 Install DNS Manager=0A=
=0A=
Link: https://opentechy.com/how-to-setup-dns-cluster-on-cwp/=0A=
=0A=
REFERENCE=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Guide: How to setup DNS cluster on CWP 2 =96 Add webservers to DNS cluster=
=0A=
=0A=
Link: https://opentechy.com/how-to-setup-dns-cluster-on-cwp-2-add-webserver=
s-to-dns-cluster/=0A=
=0A=
CONFIGURING CUSTOM NAME SERVERS AT YOUR DOMAIN REGISTRAR=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
Go to Advanced Features > Hostnames=0A=
=0A=
Host: ns1 	IP Addresses: 3.21.30.127=0A=
Host: ns2	IP Addresses: 3.12.224.179=0A=
=0A=
Nameservers: Using custom nameservers=0A=
=0A=
ns1.teo-en-ming.com=0A=
=0A=
ns2.teo-en-ming.com=0A=
=0A=
CONFIGURING NAME SERVERS ON THE MASTER CENTOS WEB PANEL WEBSERVER=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
From the left menu, click DNS Functions, then click Edit Nameservers IPs.=
=0A=
=0A=
Name Server 1: ns1.teo-en-ming.com	3.21.30.127=0A=
=0A=
Name Server 2: ns2.teo-en-ming.com	3.12.224.179=0A=
=0A=
Click Save changes.=0A=
=0A=
# systemctl restart named=0A=
=0A=
BIND DNS CONFIGURATION ON THE MASTER CENTOS WEB PANEL WEBSERVER=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
File /etc/named.conf:=0A=
=0A=
//=0A=
// named.conf=0A=
//=0A=
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS=
=0A=
// server as a caching only nameserver (as a any DNS resolver only).=0A=
//=0A=
// See /usr/share/doc/bind*/sample/ for example named configuration files.=
=0A=
//=0A=
// See the BIND Administrator's Reference Manual (ARM) for details about th=
e=0A=
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html=0A=
=0A=
options {=0A=
	listen-on port 53 { any; };=0A=
	listen-on-v6 port 53 { ::1; };=0A=
	directory 	"/var/named";=0A=
	dump-file 	"/var/named/data/cache_dump.db";=0A=
	statistics-file "/var/named/data/named_stats.txt";=0A=
	memstatistics-file "/var/named/data/named_mem_stats.txt";=0A=
	recursing-file =A0"/var/named/data/named.recursing";=0A=
	secroots-file =A0 "/var/named/data/named.secroots";=0A=
	allow-query =A0 =A0 { any; };=0A=
=0A=
	/* =0A=
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursio=
n.=0A=
	 - If you are building a RECURSIVE (caching) DNS server, you need to enabl=
e =0A=
	 =A0 recursion. =0A=
	 - If your recursive DNS server has a public IP address, you MUST enable a=
ccess =0A=
	 =A0 control to limit queries to your legitimate users. Failing to do so w=
ill=0A=
	 =A0 cause your server to become part of large scale DNS amplification =0A=
	 =A0 attacks. Implementing BCP38 within your network would greatly=0A=
	 =A0 reduce such attack surface =0A=
	*/=0A=
//	recursion no;=0A=
=0A=
	dnssec-enable yes;=0A=
	dnssec-validation yes;=0A=
=0A=
	/* Path to ISC DLV key */=0A=
	bindkeys-file "/etc/named.root.key";=0A=
=0A=
	managed-keys-directory "/var/named/dynamic";=0A=
=0A=
	pid-file "/run/named/named.pid";=0A=
	session-keyfile "/run/named/session.key";=0A=
=0A=
//Slave dns configuration=0A=
allow-transfer {3.12.224.179;};=0A=
allow-recursion {3.12.224.179;};=0A=
also-notify {3.12.224.179;};=0A=
masterfile-format text;=0A=
};=0A=
=0A=
logging {=0A=
=A0 =A0 =A0 =A0 channel default_debug {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 file "data/named.run";=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 severity dynamic;=0A=
=A0 =A0 =A0 =A0 };=0A=
};=0A=
=0A=
zone "." IN {=0A=
	type hint;=0A=
	file "named.ca";=0A=
};=0A=
=0A=
include "/etc/named.rfc1912.zones";=0A=
include "/etc/named.root.key";=0A=
=0A=
=0A=
zone "ns1.teo-en-ming.com" {type master;file "/var/named/ns1.teo-en-ming.co=
m.db";};=0A=
zone "ns2.teo-en-ming.com" {type master;file "/var/named/ns2.teo-en-ming.co=
m.db";};=0A=
=0A=
// zone teo-en-ming.com=0A=
zone "teo-en-ming.com" {type master; file "/var/named/teo-en-ming.com.db";}=
;=0A=
// zone_end teo-en-ming.com=0A=
=0A=
File /var/named/ns1.teo-en-ming.com.db:=0A=
=0A=
=0A=
; Panel %version%=0A=
; Zone file for ns1.teo-en-ming.com=0A=
$TTL 14400=0A=
ns1.teo-en-ming.com. =A0 =A0 =A086400 =A0 =A0 =A0IN =A0 =A0 =A0SOA =A0 =A0 =
=A0ns1.teo-en-ming.com. =A0 =A0 =A0info.centos-webpanel.com. =A0 =A0 =A0(=
=0A=
=A0 =A0 =A0 				2013071600 ;serial, todays date+todays=0A=
=A0 =A0 =A0 				86400 ;refresh, seconds=0A=
=A0 =A0 =A0 				7200 ;retry, seconds=0A=
=A0 =A0 =A0 				3600000 ;expire, seconds=0A=
=A0 =A0 =A0 				86400 ;minimum, seconds=0A=
=A0 =A0 =A0 )=0A=
ns1.teo-en-ming.com. 86400 IN NS ns1.teo-en-ming.com.=0A=
ns1.teo-en-ming.com. 86400 IN NS ns2.teo-en-ming.com.=0A=
ns1.teo-en-ming.com. 14400 IN A 3.21.30.127=0A=
=0A=
File /var/named/ns2.teo-en-ming.com.db:=0A=
=0A=
=0A=
; Panel %version%=0A=
; Zone file for ns2.teo-en-ming.com=0A=
$TTL 14400=0A=
ns2.teo-en-ming.com. =A0 =A0 =A086400 =A0 =A0 =A0IN =A0 =A0 =A0SOA =A0 =A0 =
=A0ns1.teo-en-ming.com. =A0 =A0 =A0info.centos-webpanel.com. =A0 =A0 =A0(=
=0A=
=A0 =A0 =A0 				2013071600 ;serial, todays date+todays=0A=
=A0 =A0 =A0 				86400 ;refresh, seconds=0A=
=A0 =A0 =A0 				7200 ;retry, seconds=0A=
=A0 =A0 =A0 				3600000 ;expire, seconds=0A=
=A0 =A0 =A0 				86400 ;minimum, seconds=0A=
=A0 =A0 =A0 )=0A=
ns2.teo-en-ming.com. 86400 IN NS ns1.teo-en-ming.com.=0A=
ns2.teo-en-ming.com. 86400 IN NS ns2.teo-en-ming.com.=0A=
ns2.teo-en-ming.com. 14400 IN A 3.12.224.179=0A=
=0A=
File /var/named/teo-en-ming.com.db:=0A=
=0A=
; Generated by CWP=0A=
; Zone file for teo-en-ming.com=0A=
$TTL 14400=0A=
@ =A0 =A086400 =A0 =A0 =A0 =A0IN =A0 =A0 =A0SOA =A0 =A0 ns1.teo-en-ming.com=
. ceo.teo-en-ming-corp.com. (=0A=
				2020022453 =A0 =A0 =A0; serial, todays date+todays=0A=
				3600 =A0 =A0 =A0 =A0 =A0 =A0; refresh, seconds=0A=
				7200 =A0 =A0 =A0 =A0 =A0 =A0; retry, seconds=0A=
				1209600 =A0 =A0 =A0 =A0 ; expire, seconds=0A=
				86400 ) =A0 =A0 =A0 =A0 ; minimum, seconds=0A=
@	86400	IN	NS		ns1.teo-en-ming.com.=0A=
@	86400	IN	NS		ns2.teo-en-ming.com.=0A=
@ IN A 3.21.30.127=0A=
localhost.teo-en-ming.com. IN A 127.0.0.1=0A=
@ IN MX 0 teo-en-ming.com.=0A=
mail 14400 IN CNAME teo-en-ming.com.=0A=
smtp 14400 IN CNAME teo-en-ming.com.=0A=
pop =A014400 IN CNAME teo-en-ming.com.=0A=
pop3 14400 IN CNAME teo-en-ming.com.=0A=
imap 14400 IN CNAME teo-en-ming.com.=0A=
webmail 14400 IN A 3.21.30.127=0A=
cpanel 14400 IN A 3.21.30.127=0A=
cwp 14400 IN A 3.21.30.127=0A=
www 14400 IN CNAME teo-en-ming.com.=0A=
ftp 14400 IN CNAME teo-en-ming.com.=0A=
_dmarc	14400	IN	TXT	"v=3DDMARC1; p=3Dnone"=0A=
@	14400	IN	TXT	"v=3Dspf1 +a +mx +ip4:3.21.30.127 ~all"=0A=
ns1.teo-en-ming.com. 14400 IN A 3.21.30.127=0A=
ns2.teo-en-ming.com. 14400 IN A 3.12.224.179=0A=
default._domainkey 14400 IN TXT "v=3DDKIM1; k=3Drsa; p=3DMIGfMA0GCSqGSIb3DQ=
EBAQUAA4GNADCBiQKBgQDEXk5wQIfKJPjTkkj0yHGX8yIJOOrsOsvAqbqVaEBFBWhRlF7YxyGzc=
haAdWEVQkozcsWPIL5DgJ7vWBoJIGqfNOT7vO/lStqNcXC+2hYVIF7MTB8i6tBW1/UDEuL8oamm=
KWDq8P9Fpduk6JppV7rtKXeFzrYj35ydIhDIKUABcwIDAQAB"=0A=
=0A=
BIND DNS CONFIGURATION ON THE SLAVE DNS MANAGER=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
File /etc/named.conf:=0A=
=0A=
//=0A=
// named.conf=0A=
//=0A=
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS=
=0A=
// server as a caching only nameserver (as a any DNS resolver only).=0A=
//=0A=
// See /usr/share/doc/bind*/sample/ for example named configuration files.=
=0A=
//=0A=
// See the BIND Administrator's Reference Manual (ARM) for details about th=
e=0A=
// configuration located in /usr/share/doc/bind-{version}/Bv9ARM.html=0A=
=0A=
options {=0A=
	listen-on port 53 { any; };=0A=
	listen-on-v6 port 53 { ::1; };=0A=
	directory 	"/var/named";=0A=
	dump-file 	"/var/named/data/cache_dump.db";=0A=
	statistics-file "/var/named/data/named_stats.txt";=0A=
	memstatistics-file "/var/named/data/named_mem_stats.txt";=0A=
	recursing-file =A0"/var/named/data/named.recursing";=0A=
	secroots-file =A0 "/var/named/data/named.secroots";=0A=
	allow-query =A0 =A0 { any; };=0A=
=0A=
	/* =0A=
	 - If you are building an AUTHORITATIVE DNS server, do NOT enable recursio=
n.=0A=
	 - If you are building a RECURSIVE (caching) DNS server, you need to enabl=
e =0A=
	 =A0 recursion. =0A=
	 - If your recursive DNS server has a public IP address, you MUST enable a=
ccess =0A=
	 =A0 control to limit queries to your legitimate users. Failing to do so w=
ill=0A=
	 =A0 cause your server to become part of large scale DNS amplification =0A=
	 =A0 attacks. Implementing BCP38 within your network would greatly=0A=
	 =A0 reduce such attack surface =0A=
	*/=0A=
	recursion no;=0A=
=0A=
	dnssec-enable yes;=0A=
	dnssec-validation yes;=0A=
=0A=
	/* Path to ISC DLV key */=0A=
	bindkeys-file "/etc/named.root.key";=0A=
=0A=
	managed-keys-directory "/var/named/dynamic";=0A=
=0A=
	pid-file "/run/named/named.pid";=0A=
	session-keyfile "/run/named/session.key";=0A=
	=0A=
	masterfile-format text;=0A=
};=0A=
=0A=
logging {=0A=
=A0 =A0 =A0 =A0 channel default_debug {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 file "data/named.run";=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 severity dynamic;=0A=
=A0 =A0 =A0 =A0 };=0A=
};=0A=
=0A=
zone "." IN {=0A=
	type hint;=0A=
	file "named.ca";=0A=
};=0A=
=0A=
include "/etc/named.rfc1912.zones";=0A=
include "/etc/named.root.key";=0A=
=0A=
=0A=
// zone teo-en-ming.com=0A=
// zone "teo-en-ming.com" {type master; file "/var/named/teo-en-ming.com.db=
";};=0A=
// zone_end teo-en-ming.com=0A=
=0A=
//Slave dns configuration=0A=
include "/etc/named/slave.conf";=0A=
=0A=
File /var/named/teo-en-ming.com.db (WRONG, DON'T USE):=0A=
=0A=
; Generated by CWP=0A=
; Zone file for teo-en-ming.com=0A=
$TTL 14400=0A=
@ =A0 =A086400 =A0 =A0 =A0 =A0IN =A0 =A0 =A0SOA =A0 =A0 ns1.centos-webpanel=
.com. ceo.teo-en-ming-corp.com. (=0A=
				2020022660 =A0 =A0 =A0; serial, todays date+todays=0A=
				3600 =A0 =A0 =A0 =A0 =A0 =A0; refresh, seconds=0A=
				7200 =A0 =A0 =A0 =A0 =A0 =A0; retry, seconds=0A=
				1209600 =A0 =A0 =A0 =A0 ; expire, seconds=0A=
				86400 ) =A0 =A0 =A0 =A0 ; minimum, seconds=0A=
@	86400	IN	NS		ns1.centos-webpanel.com.=0A=
@	86400	IN	NS		ns2.centos-webpanel.com.=0A=
@ IN A 3.12.224.179=0A=
localhost.teo-en-ming.com. IN A 127.0.0.1=0A=
@ IN MX 0 teo-en-ming.com.=0A=
mail 14400 IN CNAME teo-en-ming.com.=0A=
smtp 14400 IN CNAME teo-en-ming.com.=0A=
pop =A014400 IN CNAME teo-en-ming.com.=0A=
pop3 14400 IN CNAME teo-en-ming.com.=0A=
imap 14400 IN CNAME teo-en-ming.com.=0A=
webmail 14400 IN A 3.12.224.179=0A=
cpanel 14400 IN A 3.12.224.179=0A=
cwp 14400 IN A 3.12.224.179=0A=
www 14400 IN CNAME teo-en-ming.com.=0A=
ftp 14400 IN CNAME teo-en-ming.com.=0A=
_dmarc	14400	IN	TXT	"v=3DDMARC1; p=3Dnone"=0A=
@	14400	IN	TXT	"v=3Dspf1 +a +mx +ip4:3.12.224.179 ~all"=0A=
default._domainkey 14400 IN TXT "v=3DDKIM1; k=3Drsa; p=3DMIGfMA0GCSqGSIb3DQ=
EBAQUAA4GNADCBiQKBgQCktDYpEtFO7dyJeErMbjHvyfJYU8RqDeS7WVqQnjH4fP42JSqPmxEFX=
+QytFTlGqd6ndlz9Tjqi1iZsD0ajB/+0Pkwq/KtL6NVo2TIqnXj8VebV9+FEcx+FGvLA/b5zz+H=
fn0Bf+w/2T2bSwUm+tJoHilmANCFGlcGmpO9/lXvAwIDAQAB"=0A=
=0A=
File /etc/named/slave.conf:=0A=
=0A=
zone "teo-en-ming.com" { type slave; file "slave/db.teo-en-ming.com"; maste=
rs { 3.21.30.127; };}; //username:enming=0A=
=0A=
That's all folks!=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
-----BEGIN EMAIL SIGNATURE-----=0A=
=0A=
The Gospel for all Targeted Individuals (TIs):=0A=
=0A=
[The New York Times] Microwave Weapons Are Prime Suspect in Ills of=0A=
U.S. Embassy Workers=0A=
=0A=
Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html=0A=
=0A=
***************************************************************************=
*****************=0A=
=0A=
=0A=
=0A=
Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic=0A=
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the United=
 Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 2019) and A=
ustralia (25 Dec 2019 to 9 Jan 2020):=0A=
=0A=
=0A=
[1] https://tdtemcerts.wordpress.com/=0A=
=0A=
[2] https://tdtemcerts.blogspot.sg/=0A=
=0A=
[3] https://www.scribd.com/user/270125049/Teo-En-Ming=0A=
=0A=
-----END EMAIL SIGNATURE-----=0A=
=0A=
=0A=
=0A=

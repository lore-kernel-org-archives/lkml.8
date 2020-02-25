Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_CSS,URIBL_CSS_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE11C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7392064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgBYOGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:06:20 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:51982
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:06:20 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 09:06:19 EST
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id B4ADC4139C1;
        Tue, 25 Feb 2020 14:00:52 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 25 Feb 2020 22:00:52 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming.com
Subject: Setting Up Mail Server Operation for CentOS Web Panel Web Hosting
 Control Panel on Amazon AWS Cloud
Message-ID: <d2c38734a4a2e7f82e1a7d4e4b082317@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Setting Up Mail Server Operation for CentOS Web Panel Web 
Hosting Control Panel on Amazon AWS Cloud

Author: Mr. Turritopsis Dohrnii Teo En Ming, Singapore
Date: 25 Feb 2020 Tuesday

PREREQUISITES
=============

Before embarking on this guide, you should read the following guide 
first.

Guide: Mr. Teo En Ming's Guide to Deploying CentOS Web Panel (CWP) Web 
Hosting Control Panel on Amazon AWS Cloud

Redundant blog links:

[1] 
https://tdtemcerts.blogspot.com/2020/02/mr-teo-en-mings-guide-to-deploying.html

[2] 
https://tdtemcerts.wordpress.com/2020/02/23/mr-teo-en-mings-guide-to-deploying-centos-web-panel-cwp-web-hosting-control-panel-on-amazon-aws-cloud/

EXTREMELY DETAILED INSTRUCTIONS OF TEO EN MING'S GUIDE
======================================================

Teo En Ming's DNS Zone File for domain teo-en-ming.com on Primary DNS 
Server
============================================================================

$TTL    300
@       IN      SOA     ns1.teo-en-ming.com. ceo.teo-en-ming.com. (
          2020022502     ; Serial
              604800     ; Refresh
               86400     ; Retry
             2419200     ; Expire
              604800 )   ; Negative Cache TTL
;
; name servers - NS records
      IN      NS      ns1.teo-en-ming.com.
      IN      NS      ns2.teo-en-ming.com.

; mail servers - MX records
      IN	     MX	     0		mail.teo-en-ming.com.

; name servers - A records
ns1.teo-en-ming.com.          IN      A       13.58.253.162
ns2.teo-en-ming.com.          IN      A       3.20.186.205

; mail servers - A records
mail.teo-en-ming.com.	      IN      A       3.21.30.127

; Additional A records
www.teo-en-ming.com.          IN      A       3.21.30.127
teo-en-ming.com.	      IN      A       3.21.30.127

; Sender Policy Framework (SPF) TXT records
teo-en-ming.com.	      IN      TXT     "v=spf1 ip4:3.21.30.127 -all"

===EOF===

REFERENCE
=========

Guide: Mail Exchange Record (MX)

Link: https://www.zytrax.com/books/dns/ch8/mx.html

REFERENCE
=========

Guide: How To: Lowering Your DNS TTLs

Link: https://www.liquidweb.com/kb/how-to-lowering-your-dns-ttls/

REFERENCE
=========

Discussion: Postfix: “Connection timed out” on all outbound email 
[closed]

Link: 
https://serverfault.com/questions/585503/postfix-connection-timed-out-on-all-outbound-email

QUOTE:

"For anyone who found this question but is on AWS EC2: outgoing SMTP 
intentionally rate limited, but you can ask to have it relaxed."

REFERENCE
=========

Discussion: Intermittent exim gmail smtp connection timeout

Link: 
https://forums.cpanel.net/threads/intermittent-exim-gmail-smtp-connection-timeout.523911/

QUOTE:

"Just an update for anyone with a similar issue - with some fresh eyes 
and some more googling it sounds like this may be caused by some SMTP 
rate limitations built into the AWS EC2 network as Spam prevention.

They have a form to register to remove outgoing smtp connection 
limitations here:

https://aws.amazon.com/forms/ec2-email-limit-rdns-request

I've submitted and will update if this resolves the issues I was 
seeing."

QUOTE:

"Amazon SMTP traffic management indeed seems to have been the cause. 
Within a couple of hours of filling out the above form, I got an email 
confirmation from AWS that "traffic restrictions had been removed" and 
normal function resumed immediately.

Confusing the matters is that this SMTP traffic management is not 
documented well (and sometimes with contradicting information). It does 
not appear to be a hard cap limit, nor does it trigger any notification 
when it's applied - it actually appears to be a *throttle* on common 
SMTP ports, triggered by a very small number of connections, beyond 
which it allows a certain number of connections per/hour - which would 
absolutely create the kind of "intermittent" connectivity issues I saw 
(and the odd delivery order of mail in the queue depending on when a 
retry "won the lottery" to negotiate a connection).

Anyway - I hope that info is of some use to others in the future!"

REFERENCE
=========

Guide: Installing Telnet In CentOS/RHEL/Scientific Linux 6 & 7

Link: 
https://www.unixmen.com/installing-telnet-centosrhelscientific-linux-6-7/

Amazon Web Services' Reply to Teo En Ming
=========================================

Hello,

We approved your request for the removal of the EC2 email sending 
limitations on your Amazon Web Services account! If you requested 
removal of email sending limits on any other Amazon Elastic IPs, they've 
also been removed.

Because reverse DNS record entries are commonly considered in anti-spam 
filters, we recommend assigning a reverse DNS record to the Elastic IP 
address you use to send email to third parties. Please use the form 
located at this link to request a reverse DNS entry:
https://aws-portal.amazon.com/gp/aws/html-forms-controller/contactus/ec2-email-limit-rdns-request

If you'd like to proceed with assigning a reverse DNS record to the 
Elastic IP, the first step would be to configure the A record for the 
domain to match the desired PTR record on your side.

Please follow the instructions at the link below to create the A record:
https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-creating.html

Please let us know if you have any questions.

Regards,
Amazon Web Services

REFERENCE
=========

Guide: How to create an SPF TXT record?

Link: https://www.dmarcanalyzer.com/spf/how-to-create-an-spf-txt-record/

REFERENCE
=========

Guide: Linux BIND DNS Configure Sender Policy Framework ( SPF ) an 
e-mail Anti Forgery System

Link: 
https://www.cyberciti.biz/faq/howto-bind-djbdns-spf-antispam-dns-configuration/

Creating New User Account in CentOS Web Panel
=============================================

Login to CentOS Web Panel Admin Panel.

 From the left menu, click on User Accounts, then select New Account.

Domain name: teo-en-ming.com

Username:

Password:

Admin Email:

Server IPs:

Package: Default

Reseller: Not checked

Inode: 0

Process limit: 40

Open files: 150

Backup user account: checked

Shell Access: Disabled by default for security reasons: Unchecked

AutoSSL: Domain must be pointed to the server: Unchecked

Click Create.

Setting Up New Email Account
============================

Login to CentOS Web Panel User Panel.

 From the left menu, click Email Accounts, then click Email Accounts.

Click Add a New MailBox.

Email Address: ceo@teo-en-ming.com

Password:

Quota MB: 16000

Click Add.

Using Your New Email Account
============================

Login to Roundcube Webmail.

Click Settings.

 From the left menu, click Identities, then click ceo@teo-en-ming.com

Display Name: Turritopsis Dohrnii Teo En Ming

Click Save.

Congratulations! You can now start using your new email account.








-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
